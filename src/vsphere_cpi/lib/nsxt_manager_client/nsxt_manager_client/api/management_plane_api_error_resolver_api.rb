=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'uri'

module NSXT
  class ManagementPlaneApiErrorResolverApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Fetches metadata about the given error_id
    # Returns some metadata about the given error_id. This includes information of whether there is a resolver present for the given error_id and its associated user input data 
    # @param error_id 
    # @param [Hash] opts the optional parameters
    # @return [ErrorResolverInfo]
    def get_error_resolver_info(error_id, opts = {})
      data, _status_code, _headers = get_error_resolver_info_with_http_info(error_id, opts)
      data
    end

    # Fetches metadata about the given error_id
    # Returns some metadata about the given error_id. This includes information of whether there is a resolver present for the given error_id and its associated user input data 
    # @param error_id 
    # @param [Hash] opts the optional parameters
    # @return [Array<(ErrorResolverInfo, Fixnum, Hash)>] ErrorResolverInfo data, response status code and response headers
    def get_error_resolver_info_with_http_info(error_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiErrorResolverApi.get_error_resolver_info ...'
      end
      # verify the required parameter 'error_id' is set
      if @api_client.config.client_side_validation && error_id.nil?
        fail ArgumentError, "Missing the required parameter 'error_id' when calling ManagementPlaneApiErrorResolverApi.get_error_resolver_info"
      end
      # resource path
      local_var_path = '/error-resolver/{error_id}'.sub('{' + 'error_id' + '}', error_id.to_s)

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
        :return_type => 'ErrorResolverInfo')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiErrorResolverApi#get_error_resolver_info\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Fetches a list of metadata for all the registered error resolvers
    # Returns a list of metadata for all the error resolvers registered. 
    # @param [Hash] opts the optional parameters
    # @return [ErrorResolverInfoList]
    def list_error_resolver_info(opts = {})
      data, _status_code, _headers = list_error_resolver_info_with_http_info(opts)
      data
    end

    # Fetches a list of metadata for all the registered error resolvers
    # Returns a list of metadata for all the error resolvers registered. 
    # @param [Hash] opts the optional parameters
    # @return [Array<(ErrorResolverInfoList, Fixnum, Hash)>] ErrorResolverInfoList data, response status code and response headers
    def list_error_resolver_info_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiErrorResolverApi.list_error_resolver_info ...'
      end
      # resource path
      local_var_path = '/error-resolver'

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
        :return_type => 'ErrorResolverInfoList')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiErrorResolverApi#list_error_resolver_info\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Resolves the error
    # Invokes the corresponding error resolver for the given error(s) present in the payload 
    # @param error_resolver_metadata_list 
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def resolve_error_resolve_error(error_resolver_metadata_list, opts = {})
      resolve_error_resolve_error_with_http_info(error_resolver_metadata_list, opts)
      nil
    end

    # Resolves the error
    # Invokes the corresponding error resolver for the given error(s) present in the payload 
    # @param error_resolver_metadata_list 
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Fixnum, Hash)>] nil, response status code and response headers
    def resolve_error_resolve_error_with_http_info(error_resolver_metadata_list, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiErrorResolverApi.resolve_error_resolve_error ...'
      end
      # verify the required parameter 'error_resolver_metadata_list' is set
      if @api_client.config.client_side_validation && error_resolver_metadata_list.nil?
        fail ArgumentError, "Missing the required parameter 'error_resolver_metadata_list' when calling ManagementPlaneApiErrorResolverApi.resolve_error_resolve_error"
      end
      # resource path
      local_var_path = '/error-resolver?action=resolve_error'

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
      post_body = @api_client.object_to_http_body(error_resolver_metadata_list)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiErrorResolverApi#resolve_error_resolve_error\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
