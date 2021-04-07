=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'uri'

module NSXT
  class ManagementPlaneApiGroupingObjectsNsServiceGroupsApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Create NSServiceGroup
    # Creates a new NSServiceGroup which can contain NSServices. A given NSServiceGroup can contain either only ether type of NSServices or only non-ether type of NSServices, i.e. an NSServiceGroup cannot contain a mix of both ether and non-ether types of NSServices. 
    # @param ns_service_group 
    # @param [Hash] opts the optional parameters
    # @return [NSServiceGroup]
    def create_ns_service_group(ns_service_group, opts = {})
      data, _status_code, _headers = create_ns_service_group_with_http_info(ns_service_group, opts)
      data
    end

    # Create NSServiceGroup
    # Creates a new NSServiceGroup which can contain NSServices. A given NSServiceGroup can contain either only ether type of NSServices or only non-ether type of NSServices, i.e. an NSServiceGroup cannot contain a mix of both ether and non-ether types of NSServices. 
    # @param ns_service_group 
    # @param [Hash] opts the optional parameters
    # @return [Array<(NSServiceGroup, Fixnum, Hash)>] NSServiceGroup data, response status code and response headers
    def create_ns_service_group_with_http_info(ns_service_group, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.create_ns_service_group ...'
      end
      # verify the required parameter 'ns_service_group' is set
      if @api_client.config.client_side_validation && ns_service_group.nil?
        fail ArgumentError, "Missing the required parameter 'ns_service_group' when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.create_ns_service_group"
      end
      # resource path
      local_var_path = '/ns-service-groups'

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(ns_service_group)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NSServiceGroup')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi#create_ns_service_group\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Delete NSServiceGroup
    # Deletes the specified NSServiceGroup. By default, if the NSServiceGroup is consumed in a Firewall rule, it won't get deleted. In such situations, pass \"force=true\" as query param to force delete the NSServiceGroup. 
    # @param ns_service_group_id NSServiceGroup Id
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :force Force delete the resource even if it is being used somewhere  (default to false)
    # @return [nil]
    def delete_ns_service_group(ns_service_group_id, opts = {})
      delete_ns_service_group_with_http_info(ns_service_group_id, opts)
      nil
    end

    # Delete NSServiceGroup
    # Deletes the specified NSServiceGroup. By default, if the NSServiceGroup is consumed in a Firewall rule, it won&#39;t get deleted. In such situations, pass \&quot;force&#x3D;true\&quot; as query param to force delete the NSServiceGroup. 
    # @param ns_service_group_id NSServiceGroup Id
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :force Force delete the resource even if it is being used somewhere 
    # @return [Array<(nil, Fixnum, Hash)>] nil, response status code and response headers
    def delete_ns_service_group_with_http_info(ns_service_group_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.delete_ns_service_group ...'
      end
      # verify the required parameter 'ns_service_group_id' is set
      if @api_client.config.client_side_validation && ns_service_group_id.nil?
        fail ArgumentError, "Missing the required parameter 'ns_service_group_id' when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.delete_ns_service_group"
      end
      # resource path
      local_var_path = '/ns-service-groups/{ns-service-group-id}'.sub('{' + 'ns-service-group-id' + '}', ns_service_group_id.to_s)

      # query parameters
      query_params = {}
      query_params[:'force'] = opts[:'force'] if !opts[:'force'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi#delete_ns_service_group\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # List all NSServiceGroups
    # Returns paginated list of NSServiceGroups 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Opaque cursor to be used for getting next page of records (supplied by current result page)
    # @option opts [BOOLEAN] :default_service Fetch all default NSServiceGroups
    # @option opts [String] :included_fields Comma separated list of fields that should be included in query result
    # @option opts [Integer] :page_size Maximum number of results to return in this page (server may return fewer) (default to 1000)
    # @option opts [BOOLEAN] :sort_ascending 
    # @option opts [String] :sort_by Field by which records are sorted
    # @return [NSServiceGroupListResult]
    def list_ns_service_groups(opts = {})
      data, _status_code, _headers = list_ns_service_groups_with_http_info(opts)
      data
    end

    # List all NSServiceGroups
    # Returns paginated list of NSServiceGroups 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :cursor Opaque cursor to be used for getting next page of records (supplied by current result page)
    # @option opts [BOOLEAN] :default_service Fetch all default NSServiceGroups
    # @option opts [String] :included_fields Comma separated list of fields that should be included in query result
    # @option opts [Integer] :page_size Maximum number of results to return in this page (server may return fewer)
    # @option opts [BOOLEAN] :sort_ascending 
    # @option opts [String] :sort_by Field by which records are sorted
    # @return [Array<(NSServiceGroupListResult, Fixnum, Hash)>] NSServiceGroupListResult data, response status code and response headers
    def list_ns_service_groups_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.list_ns_service_groups ...'
      end
      if @api_client.config.client_side_validation && !opts[:'page_size'].nil? && opts[:'page_size'] > 1000
        fail ArgumentError, 'invalid value for "opts[:"page_size"]" when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.list_ns_service_groups, must be smaller than or equal to 1000.'
      end

      if @api_client.config.client_side_validation && !opts[:'page_size'].nil? && opts[:'page_size'] < 0
        fail ArgumentError, 'invalid value for "opts[:"page_size"]" when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.list_ns_service_groups, must be greater than or equal to 0.'
      end

      # resource path
      local_var_path = '/ns-service-groups'

      # query parameters
      query_params = {}
      query_params[:'cursor'] = opts[:'cursor'] if !opts[:'cursor'].nil?
      query_params[:'default_service'] = opts[:'default_service'] if !opts[:'default_service'].nil?
      query_params[:'included_fields'] = opts[:'included_fields'] if !opts[:'included_fields'].nil?
      query_params[:'page_size'] = opts[:'page_size'] if !opts[:'page_size'].nil?
      query_params[:'sort_ascending'] = opts[:'sort_ascending'] if !opts[:'sort_ascending'].nil?
      query_params[:'sort_by'] = opts[:'sort_by'] if !opts[:'sort_by'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NSServiceGroupListResult')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi#list_ns_service_groups\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Read NSServiceGroup
    # Returns information about the specified NSServiceGroup 
    # @param ns_service_group_id NSServiceGroup Id
    # @param [Hash] opts the optional parameters
    # @return [NSServiceGroup]
    def read_ns_service_group(ns_service_group_id, opts = {})
      data, _status_code, _headers = read_ns_service_group_with_http_info(ns_service_group_id, opts)
      data
    end

    # Read NSServiceGroup
    # Returns information about the specified NSServiceGroup 
    # @param ns_service_group_id NSServiceGroup Id
    # @param [Hash] opts the optional parameters
    # @return [Array<(NSServiceGroup, Fixnum, Hash)>] NSServiceGroup data, response status code and response headers
    def read_ns_service_group_with_http_info(ns_service_group_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.read_ns_service_group ...'
      end
      # verify the required parameter 'ns_service_group_id' is set
      if @api_client.config.client_side_validation && ns_service_group_id.nil?
        fail ArgumentError, "Missing the required parameter 'ns_service_group_id' when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.read_ns_service_group"
      end
      # resource path
      local_var_path = '/ns-service-groups/{ns-service-group-id}'.sub('{' + 'ns-service-group-id' + '}', ns_service_group_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NSServiceGroup')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi#read_ns_service_group\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Update NSServiceGroup
    # Updates the specified NSService. Modifiable parameters include the description, display_name and members. 
    # @param ns_service_group_id NSServiceGroup Id
    # @param ns_service_group 
    # @param [Hash] opts the optional parameters
    # @return [NSServiceGroup]
    def update_ns_service_group(ns_service_group_id, ns_service_group, opts = {})
      data, _status_code, _headers = update_ns_service_group_with_http_info(ns_service_group_id, ns_service_group, opts)
      data
    end

    # Update NSServiceGroup
    # Updates the specified NSService. Modifiable parameters include the description, display_name and members. 
    # @param ns_service_group_id NSServiceGroup Id
    # @param ns_service_group 
    # @param [Hash] opts the optional parameters
    # @return [Array<(NSServiceGroup, Fixnum, Hash)>] NSServiceGroup data, response status code and response headers
    def update_ns_service_group_with_http_info(ns_service_group_id, ns_service_group, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.update_ns_service_group ...'
      end
      # verify the required parameter 'ns_service_group_id' is set
      if @api_client.config.client_side_validation && ns_service_group_id.nil?
        fail ArgumentError, "Missing the required parameter 'ns_service_group_id' when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.update_ns_service_group"
      end
      # verify the required parameter 'ns_service_group' is set
      if @api_client.config.client_side_validation && ns_service_group.nil?
        fail ArgumentError, "Missing the required parameter 'ns_service_group' when calling ManagementPlaneApiGroupingObjectsNsServiceGroupsApi.update_ns_service_group"
      end
      # resource path
      local_var_path = '/ns-service-groups/{ns-service-group-id}'.sub('{' + 'ns-service-group-id' + '}', ns_service_group_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(ns_service_group)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NSServiceGroup')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiGroupingObjectsNsServiceGroupsApi#update_ns_service_group\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
