=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'uri'

module NSXT
  class ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Read the Routing BFD Configuration
    # Returns the BFD configuration for all routing BFD peers. This will be inherited |   by all BFD peers for LogicalRouter unless overriden while configuring the Peer. 
    # @param logical_router_id 
    # @param [Hash] opts the optional parameters
    # @return [BfdConfig]
    def read_routing_bfd_config(logical_router_id, opts = {})
      data, _status_code, _headers = read_routing_bfd_config_with_http_info(logical_router_id, opts)
      data
    end

    # Read the Routing BFD Configuration
    # Returns the BFD configuration for all routing BFD peers. This will be inherited |   by all BFD peers for LogicalRouter unless overriden while configuring the Peer. 
    # @param logical_router_id 
    # @param [Hash] opts the optional parameters
    # @return [Array<(BfdConfig, Fixnum, Hash)>] BfdConfig data, response status code and response headers
    def read_routing_bfd_config_with_http_info(logical_router_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi.read_routing_bfd_config ...'
      end
      # verify the required parameter 'logical_router_id' is set
      if @api_client.config.client_side_validation && logical_router_id.nil?
        fail ArgumentError, "Missing the required parameter 'logical_router_id' when calling ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi.read_routing_bfd_config"
      end
      # resource path
      local_var_path = '/logical-routers/{logical-router-id}/routing/bfd-config'.sub('{' + 'logical-router-id' + '}', logical_router_id.to_s)

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
        :return_type => 'BfdConfig')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi#read_routing_bfd_config\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Update the BFD Configuration for BFD peers for routing
    # Modifies the BFD configuration for routing BFD peers. Note - the configuration |   changes apply only to those routing BFD peers for which the BFD configuration has |   not been overridden at Peer level. 
    # @param logical_router_id 
    # @param bfd_config 
    # @param [Hash] opts the optional parameters
    # @return [BfdConfig]
    def update_routing_bfd_config(logical_router_id, bfd_config, opts = {})
      data, _status_code, _headers = update_routing_bfd_config_with_http_info(logical_router_id, bfd_config, opts)
      data
    end

    # Update the BFD Configuration for BFD peers for routing
    # Modifies the BFD configuration for routing BFD peers. Note - the configuration |   changes apply only to those routing BFD peers for which the BFD configuration has |   not been overridden at Peer level. 
    # @param logical_router_id 
    # @param bfd_config 
    # @param [Hash] opts the optional parameters
    # @return [Array<(BfdConfig, Fixnum, Hash)>] BfdConfig data, response status code and response headers
    def update_routing_bfd_config_with_http_info(logical_router_id, bfd_config, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi.update_routing_bfd_config ...'
      end
      # verify the required parameter 'logical_router_id' is set
      if @api_client.config.client_side_validation && logical_router_id.nil?
        fail ArgumentError, "Missing the required parameter 'logical_router_id' when calling ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi.update_routing_bfd_config"
      end
      # verify the required parameter 'bfd_config' is set
      if @api_client.config.client_side_validation && bfd_config.nil?
        fail ArgumentError, "Missing the required parameter 'bfd_config' when calling ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi.update_routing_bfd_config"
      end
      # resource path
      local_var_path = '/logical-routers/{logical-router-id}/routing/bfd-config'.sub('{' + 'logical-router-id' + '}', logical_router_id.to_s)

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
      post_body = @api_client.object_to_http_body(bfd_config)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'BfdConfig')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiLogicalRoutingAndServicesRoutingBfdConfigurationApi#update_routing_bfd_config\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
