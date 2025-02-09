require 'spec_helper'

module VSphereCloud::Resources
  describe Cluster, fake_logger: true do
    subject(:cluster) do
      VSphereCloud::Resources::Cluster.new(
        cluster_config,
        properties,
        client,
        "fake-dc"
      )
    end
    let(:datacenter_name) { 'fake-dc' }
    let(:datacenter) { instance_double('VSphereCloud::Resources::Datacenter', name: datacenter_name) }

    let(:log_output) { StringIO.new("") }
    let(:client) { instance_double('VSphereCloud::VCenterClient', cloud_searcher: cloud_searcher) }
    let(:cloud_searcher) { instance_double('VSphereCloud::CloudSearcher') }

    let(:cluster_config) do
      instance_double(
        'VSphereCloud::ClusterConfig',
        name: 'fake-cluster-name',
        resource_pool: 'fake-resource-pool',
        host_group_name: nil,
        host_group_drs_rule: 'SHOULD',
      )
    end

    let(:properties) do
      {
        :obj => cluster_mob,
        'host' => cluster_hosts,
        'datastore' => 'fake-datastore-name',
        'resourcePool' => fake_resource_pool_mob,
      }
    end
    let(:fake_cluster_mob_host) { double('VimSdk::Vim::HostSystem') }
    let(:cluster_mob) { instance_double('VimSdk::Vim::ClusterComputeResource', name: 'cluster1', host: fake_cluster_mob_host) }
    let(:cluster_hosts) { [instance_double('VimSdk::Vim::HostSystem')] }
    let(:fake_resource_pool_mob) { instance_double('VimSdk::Vim::ResourcePool') }

    let(:fake_resource_pool) do
      instance_double('VSphereCloud::Resources::ResourcePool',
                      mob: fake_resource_pool_mob, name: 'rp1'
      )
    end
    let(:fake_resource_pool_mob) { instance_double('VimSdk::Vim::ResourcePool') }

    let(:fake_available_host_mount_mob) { instance_double('VimSdk::Vim::Datastore::HostMount', key: 'an-INCLUDED-key') }
    let(:fake_unavailable_host_mount_mob) { instance_double('VimSdk::Vim::Datastore::HostMount', key: 'an-EXCLUDED-key') }

    let(:ephemeral_store_datastore_mob) { instance_double('VimSdk::Vim::Datastore', host: [fake_available_host_mount_mob]) }
    let(:ephemeral_store_properties) { {obj: ephemeral_store_datastore_mob,'name' => 'ephemeral_1', 'summary.freeSpace' => 15000 * BYTES_IN_MB} }
    let(:ephemeral_store_2_datastore_mob) { instance_double('VimSdk::Vim::Datastore', host: [fake_available_host_mount_mob]) }
    let(:ephemeral_store_2_properties) { {obj: ephemeral_store_2_datastore_mob,'name' => 'ephemeral_2', 'summary.freeSpace' => 25000 * BYTES_IN_MB} }
    let(:persistent_store_datastore_mob) { instance_double('VimSdk::Vim::Datastore', host: [fake_available_host_mount_mob]) }
    let(:persistent_store_properties) { {obj: persistent_store_datastore_mob,'name' => 'persistent_1', 'summary.freeSpace' => 10000 * BYTES_IN_MB, 'summary.capacity' => 20000 * BYTES_IN_MB} }
    let(:persistent_store_2_datastore_mob) { instance_double('VimSdk::Vim::Datastore', host: [fake_available_host_mount_mob]) }
    let(:persistent_store_2_properties) { {obj: persistent_store_2_datastore_mob,'name' => 'persistent_2', 'summary.freeSpace' => 20000 * BYTES_IN_MB, 'summary.capacity' => 40000 * BYTES_IN_MB} }
    let(:inaccessible_persistent_store_datastore_mob) { instance_double('VimSdk::Vim::Datastore', host: [fake_unavailable_host_mount_mob]) }
    let(:inaccessible_persistent_store_properties) { {obj: inaccessible_persistent_store_datastore_mob,'name' => 'persistent_inaccess'} }
    let(:other_store_properties) { {obj: inaccessible_persistent_store_datastore_mob, 'name' => 'other' } }

    let(:fake_datastore_properties) do
      {
        keys: ephemeral_store_properties,
        are: ephemeral_store_2_properties,
        ignored: persistent_store_properties,
        in: persistent_store_2_properties,
        this: inaccessible_persistent_store_properties,
        hash: other_store_properties,
      }
    end

    let(:fake_runtime_info) do
      instance_double(
        'VimSdk::Vim::ResourcePool::RuntimeInfo',
        overall_status: 'red',
      )
    end

    before do
      allow(ResourcePool).to receive(:new).with(
        client, cluster_config, fake_resource_pool_mob, datacenter_name
      ).and_return(fake_resource_pool)

      allow(cloud_searcher).to receive(:get_properties).with(
        'fake-datastore-name', VimSdk::Vim::Datastore, Datastore::PROPERTIES, {}
      ).and_return(fake_datastore_properties)

      allow(cloud_searcher).to receive(:get_properties).with(
        fake_resource_pool_mob, VimSdk::Vim::ResourcePool, "summary"
      ).and_return({
        'summary' => instance_double('VimSdk::Vim::ResourcePool::Summary', runtime: fake_runtime_info)
      })
    end

    describe '#accessible_datastores' do
      before do
        allow(fake_available_host_mount_mob).to receive_message_chain(:key, :runtime, :in_maintenance_mode).and_return(false)
        allow(fake_available_host_mount_mob).to receive_message_chain(:mount_info,:accessible).and_return(true)

        allow(fake_unavailable_host_mount_mob).to receive_message_chain(:key, :runtime, :in_maintenance_mode).and_return(false)
        allow(fake_unavailable_host_mount_mob).to receive_message_chain(:mount_info,:accessible).and_return(true)

        allow(fake_cluster_mob_host).to receive(:include?).with(fake_available_host_mount_mob.key).and_return(true)
        allow(fake_cluster_mob_host).to receive(:include?).with(fake_unavailable_host_mount_mob.key).and_return(false)
      end

      it 'returns the full list of datastores without inaccessible stores' do
        accessible_datastores = cluster.accessible_datastores
        expect(accessible_datastores.keys).to match_array(%w(persistent_1 persistent_2 ephemeral_1 ephemeral_2))
        expect(accessible_datastores['persistent_1'].name).to eq('persistent_1')
        expect(accessible_datastores['persistent_2'].name).to eq('persistent_2')
        expect(accessible_datastores['ephemeral_1'].name).to eq('ephemeral_1')
        expect(accessible_datastores['ephemeral_2'].name).to eq('ephemeral_2')
      end

      context 'when cluster has access to zero datastores' do
        let(:properties) do
          {
            :obj => cluster_mob,
            'host' => cluster_hosts,
            'datastore' => [],
            'resourcePool' => fake_resource_pool_mob,
          }
        end
        it 'returns the empty list of datastores' do
          accessible_ds =  cluster.accessible_datastores
          expect(accessible_ds).to be_empty
        end
      end
    end

    describe 'cluster utilization' do
      context 'when we are using resource pools' do
        context 'when utilization data is available' do
          context 'when the runtime status is green' do
            let(:fake_runtime_info) do
              instance_double(
                'VimSdk::Vim::ResourcePool::RuntimeInfo',
                overall_status: 'green',
                memory: instance_double(
                  'VimSdk::Vim::ResourcePool::ResourceUsage',
                  max_usage: 1024 * 1024 * 100,
                  overall_usage: 1024 * 1024 * 75,
                )
              )
            end

            it 'sets resources to values in the runtime status' do
              expect(cluster.free_memory.cluster_free_memory).to eq(25)
              expect(cluster.free_memory.host_group_free_memory).to eq(25)
            end
          end
        end
      end

      context 'when we are using clusters directly without host groups' do
        def generate_host_property(mob:, name:, connection_state:, maintenance_mode:, memory_size:, power_state:)
          {
            mob => {
              'name' => name,
              'hardware.memorySize' => memory_size,
              'runtime.connectionState' => connection_state,
              'runtime.inMaintenanceMode' => maintenance_mode ? 'true' : 'false',
              'runtime.powerState' => power_state,
              :obj => mob,
            }
          }
        end

        before do
          allow(cluster_config).to receive(:resource_pool).and_return(nil)
        end

        let(:active_host_1_mob) { instance_double('VimSdk::Vim::ClusterComputeResource') }
        let(:active_host_2_mob) { instance_double('VimSdk::Vim::ClusterComputeResource') }
        let(:active_host_mobs) { [active_host_1_mob, active_host_2_mob] }
        let(:compute_summary) { instance_double('VimSdk::Vim::ComputeResource::Summary') }
        let(:active_hosts_properties) do
          {}.merge(
            generate_host_property(mob: active_host_1_mob, name: 'mob-1', maintenance_mode: false, memory_size: 100 * 1024 * 1024, power_state: 'poweredOn', connection_state: 'connected')
          ).merge(
            generate_host_property(mob: active_host_2_mob, name: 'mob-2', maintenance_mode: false, memory_size: 40 * 1024 * 1024, power_state: 'poweredOn', connection_state: 'connected')
          )
        end
        let(:hosts_properties) { active_hosts_properties }

        before do
          allow(cloud_searcher).to receive(:get_properties).and_return({"summary" => compute_summary})
          allow(compute_summary).to receive(:effective_memory).and_return(85)
        end

        it 'sets resources to values based on the active hosts in the cluster' do
          expect(cluster.free_memory.cluster_free_memory).to eq(85)
          expect(cluster.free_memory.host_group_free_memory).to eq(85)
        end

        context 'when an ESXi host is not powered on' do
          let(:hosts_properties) do
            {}.merge(
              generate_host_property(mob: instance_double('VimSdk::Vim::ClusterComputeResource'), name: 'fake-powered-off', maintenance_mode: false, memory_size: 5 * 1024 * 1024, power_state: 'poweredOff', connection_state: 'connected')
            ).merge(
               active_hosts_properties
            )
          end

          it 'includes the free memory of only powered on hosts' do
            expect(cluster.free_memory.cluster_free_memory).to eq(85)
            expect(cluster.free_memory.host_group_free_memory).to eq(85)
          end
        end

        context 'when an ESXi host is disconnected' do
          let(:hosts_properties) do
            {}.merge(
              generate_host_property(mob: instance_double('VimSdk::Vim::ClusterComputeResource'), name: 'fake-host-disc', maintenance_mode: false, memory_size: 5 * 1024 * 1024, power_state: 'poweredOn', connection_state: 'disconnected')
            ).merge(
              active_hosts_properties
            )
          end

          it 'includes the free memory of only connected hosts' do
            expect(cluster.free_memory.cluster_free_memory).to eq(85)
            expect(cluster.free_memory.host_group_free_memory).to eq(85)
          end
        end

        context 'when an ESXi host is in maintenance mode' do
          let(:hosts_properties) do
            {}.merge(
              generate_host_property(mob: instance_double('VimSdk::Vim::ClusterComputeResource'), name: 'fake-host-maint', maintenance_mode: true, memory_size: 5 * 1024 * 1024, power_state: 'poweredOn', connection_state: 'connected')
            ).merge(
               active_hosts_properties
            )
          end

          it 'includes the free memory of only hosts not in maintenance mode' do
            expect(cluster.free_memory.cluster_free_memory).to eq(85)
            expect(cluster.free_memory.host_group_free_memory).to eq(85)
          end
        end

        context 'when there are no active cluster hosts' do
          let(:hosts_properties) do
            {}.merge(
              generate_host_property(mob: instance_double('VimSdk::Vim::ClusterComputeResource'), name: 'fake-host-inactive', maintenance_mode: false, memory_size: 5 * 1024 * 1024, power_state: 'poweredOff', connection_state: 'disconnected')
            )
          end
          before do
            allow(compute_summary).to receive(:effective_memory).and_return(0)
          end
          it 'defaults free memory to zero' do
            expect(cluster.free_memory.cluster_free_memory).to eq(0)
            expect(cluster.free_memory.host_group_free_memory).to eq(0)
          end
        end
      end

      context 'when we are using host groups in cluster' do
        before do
          allow(cluster_config).to receive(:resource_pool).and_return(nil)
          allow(subject).to receive_message_chain(:host_group_mob,
            :host).and_return([host1, host2])
          allow(subject).to receive_messages(host_group: 'fake-host-group')
          allow(subject).to receive(:host_group_rule_type).and_return('MUST')
          allow(host1).to receive_message_chain(:hardware,
            :memory_size).and_return(10 * 1024 * 1024)
          allow(host2).to receive_message_chain(:hardware,
            :memory_size).and_return(10 * 1024 * 1024)
          allow(host1).to receive_message_chain(:summary, :quick_stats,
            :overall_memory_usage).and_return(1)
          allow(host2).to receive_message_chain(:summary, :quick_stats,
            :overall_memory_usage).and_return(1)
          allow(host1).to receive_message_chain(:runtime,
            :connection_state).and_return('connected')
          allow(host2).to receive_message_chain(:runtime,
            :in_maintenance_mode).and_return(false)
          allow(host2).to receive_message_chain(:runtime,
            :connection_state).and_return('connected')
          allow(host1).to receive_message_chain(:runtime,
            :in_maintenance_mode).and_return(false)
        end

        let(:host1) { instance_double('VimSdk::Vim::HostSystem') }
        let(:host2) { instance_double('VimSdk::Vim::HostSystem') }

        context 'when host group rule type is MUST' do
          it 'returns sum of raw available memory on two hosts in Megabytes for cluster free memory' do
            expect(cluster.free_memory.cluster_free_memory).to eq(18)
          end

          it 'returns sum of raw available memory on two hosts in Megabytes for host group free memory' do
            expect(cluster.free_memory.host_group_free_memory).to eq(18)
          end
        end

        context 'when host group rule type is SHOULD' do
          let(:compute_summary) { instance_double('VimSdk::Vim::ComputeResource::Summary') }

          before do
            allow(subject).to receive(:host_group_rule_type).and_return('SHOULD')
            allow(cloud_searcher).to receive(:get_properties).and_return({"summary" => compute_summary})
            allow(compute_summary).to receive(:effective_memory).and_return(85)
          end

          it 'returns full cluster free memory in Megabytes for cluster free memory' do
            expect(cluster.free_memory.cluster_free_memory).to eq(85)
          end

          it 'returns sum of raw available memory on two hosts in Megabytes for host group free memory' do
            expect(cluster.free_memory.host_group_free_memory).to eq(18)
          end
        end

        context 'when host hardware summary is not available' do
          before do
            expect(host1).to receive_messages(hardware: nil)
            expect(host2).to receive_messages(hardware: nil)
          end

          it 'returns 0' do
            expect(cluster.free_memory.cluster_free_memory).to eq(0)
            expect(cluster.free_memory.host_group_free_memory).to eq(0)
          end
        end

        context 'when all hosts are in maintenace mode or not connected' do
          before do
            allow(host1).to receive_message_chain(:runtime,
              :connection_state).and_return('not connected')
            allow(host2).to receive_message_chain(:runtime,
              :in_maintenance_mode).and_return(true)
          end

          it 'returns 0' do
            expect(cluster.free_memory.cluster_free_memory).to eq(0)
            expect(cluster.free_memory.host_group_free_memory).to eq(0)
          end
        end
      end
    end

    describe '#free_memory' do
      let(:fake_runtime_info) do
        instance_double(
          'VimSdk::Vim::ResourcePool::RuntimeInfo',
          overall_status: 'green',
          memory: instance_double(
            'VimSdk::Vim::ResourcePool::ResourceUsage',
            max_usage: 1024 * 1024 * 100,
            overall_usage: 1024 * 1024 * 75,
          )
        )
      end

      it 'returns the amount of free memory in the cluster' do
        expect(cluster.free_memory.cluster_free_memory).to eq(25)
        expect(cluster.free_memory.host_group_free_memory).to eq(25)
      end

      context 'when we fail to get the utilization for a resource pool' do
        before do
          allow(cloud_searcher).to receive(:get_properties)
                                     .with(fake_resource_pool_mob, VimSdk::Vim::ResourcePool, "summary")
                                     .and_return(nil)
        end

        it 'raises an exception' do
          expect { cluster.free_memory }.to raise_error("Failed to get utilization for resource pool '#{fake_resource_pool}'")
        end
      end
    end

    describe 'host groups and vm groups are defined in AZ' do
      describe '#vm_group' do
        let(:cluster_config) do
          instance_double(
            'VSphereCloud::ClusterConfig',
            name: 'fake-cluster-name',
            resource_pool: 'fake-resource-pool',
            host_group_name: 'vcpi-hg1',
          )
        end
        before do
          expect(subject).to receive(:rule_type_suffix).and_return(rule_type_suffix)
        end
        context 'when rule type is must rule' do
          let(:rule_type_suffix) { 'must' }
          it 'returns host_group name suffixed with _vm_group and rule type' do
            expect(cluster.vm_group).to eq(cluster.host_group+rule_type_suffix+VSphereCloud::Resources::Cluster::CLUSTER_VM_GROUP_SUFFIX)
          end
        end
        context 'when rule type is should rule' do
          let(:rule_type_suffix) { 'should' }
          it 'returns host_group name suffixed with _vm_group and rule type' do
            expect(cluster.vm_group).to eq(cluster.host_group+rule_type_suffix+VSphereCloud::Resources::Cluster::CLUSTER_VM_GROUP_SUFFIX)
          end
        end
      end
      context 'when host group name is longer than 100 characters' do
        let(:cluster_config) do
          instance_double(
            'VSphereCloud::ClusterConfig',
            name: 'fake-cluster-name',
            host_group_name: 'vcpi-hg1'*20,
          )
        end
        before do
          expect(subject).to receive(:rule_type_suffix).and_return(rule_type_suffix)
        end
        context 'when rule type is must rule' do
          let(:rule_type_suffix) { 'must' }
          it 'returns a random name that includes "must" ' do
            expect(cluster.vm_group).to include(rule_type_suffix)
          end
        end
        context 'when rule type is should rule' do
          let(:rule_type_suffix) { 'should' }
          it 'returns a random name that includes "should" ' do
            expect(cluster.vm_group).to include(rule_type_suffix)
          end
        end
      end
      describe '#host_group' do
        context 'when host group is not defined in config' do
          it 'returns nil' do
            expect(cluster.host_group).to be(nil)
          end
        end
        context 'when host group is defined in config' do
          let(:cluster_config) do
            instance_double(
              'VSphereCloud::ClusterConfig',
              name: 'fake-cluster-name',
              host_group_name: 'fake-host-group',
              host_group_drs_rule: 'MUST',
            )
          end
          it 'returns name of the defined host Group)' do
            expect(cluster.host_group).to eq('fake-host-group')
          end
        end
      end
      describe '#host_group_drs_rule' do
        context 'when host group is not defined in config' do
          it 'returns SHOULD' do
            expect(cluster.host_group_drs_rule).to eq('SHOULD')
          end
        end
        context 'when host group drs rule is defined in config' do
          let(:cluster_config) do
            instance_double(
                'VSphereCloud::ClusterConfig',
                name: 'fake-cluster-name',
                host_group_name: 'fake-host-group',
                host_group_drs_rule: 'MUST',
                )
          end
          it 'returns name of the defined host Group drs rule' do
            expect(cluster.host_group_drs_rule).to eq('MUST')
          end
        end
      end
      describe '#vm_host_affinity_rule_name' do
        context 'when host group is not defined(nil)' do
          it 'returns nil' do
            expect(cluster.vm_host_affinity_rule_name).to be(nil)
          end
        end
        context 'when host group is defined' do
          let(:cluster_config) do
            instance_double(
              'VSphereCloud::ClusterConfig',
              name: 'fake-cluster-name',
              host_group_name: 'fake-host-group',
            )
          end
          let(:rule_type_suffix) { 'must' }
          before do
            allow(subject).to receive(:rule_type_suffix).and_return(rule_type_suffix)
          end
          context 'when rule type is must rule' do
            let(:rule_type_suffix) { 'must' }
            it 'returns rule name suffixed with rule type' do
              expect(cluster.vm_host_affinity_rule_name).to eq(cluster.vm_group + VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SUFFIX)
              expect(cluster.vm_host_affinity_rule_name).to include(rule_type_suffix)
            end
          end
          context 'when rule type is should rule' do
            let(:rule_type_suffix) { 'should' }
            it 'returns rule name suffixed with rule type' do
              expect(cluster.vm_host_affinity_rule_name).to eq(cluster.vm_group + VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SUFFIX)
              expect(cluster.vm_host_affinity_rule_name).to include(rule_type_suffix)
            end
          end
        end
      end
      describe '#host_group_mob' do
        context 'when host group is not defined' do
          it 'returns nil' do
            expect(cluster.host_group_mob).to be(nil)
          end
        end
        context 'when host group is defined' do
          let(:host_group_mob) do
            instance_double('VimSdk::Vim::Cluster::HostGroup', name: 'fake-host-group', is_a?: VimSdk::Vim::Cluster::HostGroup)
          end
          let(:cluster_config) do
            instance_double(
              'VSphereCloud::ClusterConfig',
              name: 'fake-cluster-name',
              host_group_name: 'fake-host-group',
            )
          end
          it 'returns mob of defined host group' do
            allow(cluster).to receive_message_chain(:mob, :configuration_ex, :group).and_return([host_group_mob])
            expect(cluster.host_group_mob).to be(host_group_mob)
          end
        end
        context 'when host group is defined with a wrong name' do
          let(:host_group_mob) do
            instance_double('VimSdk::Vim::Cluster::HostGroup', name: 'another-fake-host-group', is_a?: VimSdk::Vim::Cluster::HostGroup)
          end
          let(:cluster_config) do
            instance_double(
              'VSphereCloud::ClusterConfig',
              name: 'fake-cluster-name',
              host_group_name: 'fake-host-group',
            )
          end
          it 'returns mob of defined host group' do
            allow(cluster).to receive_message_chain(:mob, :configuration_ex, :group).and_return([host_group_mob])
            expect{cluster.host_group_mob}.to raise_error(/Failed to find the HostGroup/)
          end
        end
      end
      describe '#rule_type_suffix' do
        context 'when host group rule type is not defined(nil)' do
          it 'returns SHOULD' do
            expect(cluster.rule_type_suffix).to be(VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SHOULD)
          end
        end
        context 'when host group rule type is defined' do
          let(:cluster_config) do
            instance_double(
                'VSphereCloud::ClusterConfig',
                name: 'fake-cluster-name',
                host_group_name: 'fake-host-group',
                host_group_drs_rule: host_group_drs_rule
                )
          end
          let(:host_group_drs_rule) { nil }
          context 'when rule type has a bad value' do
            let(:host_group_drs_rule) { 'a bad value' }
            it 'returns SHOULD type suffix' do
              expect(cluster.rule_type_suffix).to eq(VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SHOULD)
            end
          end
          context 'when rule type has shoULD (with mixed case)' do
            let(:host_group_drs_rule) { 'shoULD' }
            it 'returns SHOULD type suffix' do
              expect(cluster.rule_type_suffix).to eq(VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SHOULD)
            end
          end
          context 'when rule type has " shouLd  " (with mixed case and leading & trailing spaces)' do
            let(:host_group_drs_rule) { ' shouLd  ' }
            it 'returns SHOULD type suffix' do
              expect(cluster.rule_type_suffix).to eq(VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_SHOULD)
            end
          end
          context 'when rule type has must' do
            let(:host_group_drs_rule) { 'Must' }
            it 'returns MUST type suffix' do
              expect(cluster.rule_type_suffix).to eq(VSphereCloud::Resources::Cluster::CLUSTER_VM_HOST_RULE_MUST)
            end
          end
        end
      end
    end

    describe '#mob' do
      it 'returns the cluster mob' do
        expect(cluster.mob).to eq(cluster_mob)
      end
    end

    describe '#resource_pool' do
      it 'returns a resource pool object backed by the resource pool in the cloud properties' do
        expect(cluster.resource_pool).to eq(fake_resource_pool)
        expect(ResourcePool).to have_received(:new).with(client, cluster_config, fake_resource_pool_mob,
                                                         datacenter_name)
      end
    end

    describe '#name' do
      it 'returns the name from the configuration' do
        expect(cluster.name).to eq('fake-cluster-name')
      end
    end

    describe '#host' do
      let(:hosts) { instance_double('VimSdk::Vim::HostSystem') }

      context 'when a host group is not defined' do
        it 'returns all hosts in the cluster' do
          allow(cluster_mob).to receive(:host).and_return([hosts])
          expect(cluster.host).to eq([hosts])
        end
      end

      context 'when a host group is defined' do
        let(:host_group_hosts) { instance_double('VimSdk::Vim::HostSystem') }
        let(:host_group_mob) do
          instance_double('VimSdk::Vim::Cluster::HostGroup',
            host: [host_group_hosts])
        end
        let(:cluster_config) do
          instance_double(
            'VSphereCloud::ClusterConfig',
            name: 'fake-cluster-name',
            host_group_name: 'fake-host-group',
          )
        end

        context 'when the cluster-VM affinity type is "must"' do
          it 'returns the hosts defined under the host group' do
            allow(cluster).to receive(:host_group_mob).and_return(host_group_mob)
            allow(cluster).to receive(:host_group_rule_type).and_return('MUST')
            allow(host_group_mob).to receive(:host).and_return([host_group_hosts])
            expect(cluster.host).to eq([host_group_hosts])
          end
        end

        context 'when the cluster-VM affinity type is "should"' do
          it 'returns all hosts in the cluster' do
            allow(cluster).to receive(:host_group_mob).and_return(host_group_mob)
            allow(cluster).to receive(:host_group_rule_type).and_return('SHOULD')
            allow(cluster_mob).to receive(:host).and_return([hosts])
            expect(cluster.host).to eq([hosts])
          end
        end
      end
    end

    describe '#to_s' do
      it 'show relevant info' do
        expect(subject.to_s).to eq("(#{subject.class.name} (name=\"fake-cluster-name\"))")
      end
    end
  end
end
