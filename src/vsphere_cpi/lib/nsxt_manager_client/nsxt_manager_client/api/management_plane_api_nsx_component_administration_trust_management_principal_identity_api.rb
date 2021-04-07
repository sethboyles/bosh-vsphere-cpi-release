=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'uri'

module NSXT
  class ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Delete a principal identity
    # Delete a principal identity. It does not delete the certificate. 
    # @param principal_identity_id Unique id of the principal identity to delete
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def delete_principal_identity(principal_identity_id, opts = {})
      delete_principal_identity_with_http_info(principal_identity_id, opts)
      nil
    end

    # Delete a principal identity
    # Delete a principal identity. It does not delete the certificate. 
    # @param principal_identity_id Unique id of the principal identity to delete
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Fixnum, Hash)>] nil, response status code and response headers
    def delete_principal_identity_with_http_info(principal_identity_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.delete_principal_identity ...'
      end
      # verify the required parameter 'principal_identity_id' is set
      if @api_client.config.client_side_validation && principal_identity_id.nil?
        fail ArgumentError, "Missing the required parameter 'principal_identity_id' when calling ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.delete_principal_identity"
      end
      # resource path
      local_var_path = '/trust-management/principal-identities/{principal-identity-id}'.sub('{' + 'principal-identity-id' + '}', principal_identity_id.to_s)

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
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#delete_principal_identity\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Return the list of principal identities
    # Returns the list of principals registered with a certificate.
    # @param [Hash] opts the optional parameters
    # @return [PrincipalIdentityList]
    def get_principal_identities(opts = {})
      data, _status_code, _headers = get_principal_identities_with_http_info(opts)
      data
    end

    # Return the list of principal identities
    # Returns the list of principals registered with a certificate.
    # @param [Hash] opts the optional parameters
    # @return [Array<(PrincipalIdentityList, Fixnum, Hash)>] PrincipalIdentityList data, response status code and response headers
    def get_principal_identities_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.get_principal_identities ...'
      end
      # resource path
      local_var_path = '/trust-management/principal-identities'

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
        :return_type => 'PrincipalIdentityList')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#get_principal_identities\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Get a Principal Identity
    # Get a stored principal identity 
    # @param principal_identity_id ID of Principal Identity to get
    # @param [Hash] opts the optional parameters
    # @return [PrincipalIdentity]
    def get_principal_identity(principal_identity_id, opts = {})
      data, _status_code, _headers = get_principal_identity_with_http_info(principal_identity_id, opts)
      data
    end

    # Get a Principal Identity
    # Get a stored principal identity 
    # @param principal_identity_id ID of Principal Identity to get
    # @param [Hash] opts the optional parameters
    # @return [Array<(PrincipalIdentity, Fixnum, Hash)>] PrincipalIdentity data, response status code and response headers
    def get_principal_identity_with_http_info(principal_identity_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.get_principal_identity ...'
      end
      # verify the required parameter 'principal_identity_id' is set
      if @api_client.config.client_side_validation && principal_identity_id.nil?
        fail ArgumentError, "Missing the required parameter 'principal_identity_id' when calling ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.get_principal_identity"
      end
      # resource path
      local_var_path = '/trust-management/principal-identities/{principal-identity-id}'.sub('{' + 'principal-identity-id' + '}', principal_identity_id.to_s)

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
        :return_type => 'PrincipalIdentity')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#get_principal_identity\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Register a name-certificate combination.
    # Associates a principal's name with a certificate that is used to authenticate. Deprecated, use POST /trust-management/principal-identities/with-certificate instead. 
    # @param principal_identity 
    # @param [Hash] opts the optional parameters
    # @return [PrincipalIdentity]
    def register_principal_identity(principal_identity, opts = {})
      data, _status_code, _headers = register_principal_identity_with_http_info(principal_identity, opts)
      data
    end

    # Register a name-certificate combination.
    # Associates a principal&#39;s name with a certificate that is used to authenticate. Deprecated, use POST /trust-management/principal-identities/with-certificate instead. 
    # @param principal_identity 
    # @param [Hash] opts the optional parameters
    # @return [Array<(PrincipalIdentity, Fixnum, Hash)>] PrincipalIdentity data, response status code and response headers
    def register_principal_identity_with_http_info(principal_identity, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.register_principal_identity ...'
      end
      # verify the required parameter 'principal_identity' is set
      if @api_client.config.client_side_validation && principal_identity.nil?
        fail ArgumentError, "Missing the required parameter 'principal_identity' when calling ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.register_principal_identity"
      end
      # resource path
      local_var_path = '/trust-management/principal-identities'

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
      post_body = @api_client.object_to_http_body(principal_identity)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PrincipalIdentity')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#register_principal_identity\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Register a name-certificate combination.
    # Create a Principal Identity with a new, unused, certificate. 
    # @param principal_identity_with_certificate 
    # @param [Hash] opts the optional parameters
    # @return [PrincipalIdentity]
    def register_principal_identity_with_certificate(principal_identity_with_certificate, opts = {})
      data, _status_code, _headers = register_principal_identity_with_certificate_with_http_info(principal_identity_with_certificate, opts)
      data
    end

    # Register a name-certificate combination.
    # Create a Principal Identity with a new, unused, certificate. 
    # @param principal_identity_with_certificate 
    # @param [Hash] opts the optional parameters
    # @return [Array<(PrincipalIdentity, Fixnum, Hash)>] PrincipalIdentity data, response status code and response headers
    def register_principal_identity_with_certificate_with_http_info(principal_identity_with_certificate, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.register_principal_identity_with_certificate ...'
      end
      # verify the required parameter 'principal_identity_with_certificate' is set
      if @api_client.config.client_side_validation && principal_identity_with_certificate.nil?
        fail ArgumentError, "Missing the required parameter 'principal_identity_with_certificate' when calling ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.register_principal_identity_with_certificate"
      end
      # resource path
      local_var_path = '/trust-management/principal-identities/with-certificate'

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
      post_body = @api_client.object_to_http_body(principal_identity_with_certificate)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PrincipalIdentity')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#register_principal_identity_with_certificate\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Update a Principal Identity's certificate
    # Update a principal identity's certificate 
    # @param update_principal_identity_certificate_request 
    # @param [Hash] opts the optional parameters
    # @return [PrincipalIdentity]
    def update_principal_identity_certificate_update_certificate(update_principal_identity_certificate_request, opts = {})
      data, _status_code, _headers = update_principal_identity_certificate_update_certificate_with_http_info(update_principal_identity_certificate_request, opts)
      data
    end

    # Update a Principal Identity&#39;s certificate
    # Update a principal identity&#39;s certificate 
    # @param update_principal_identity_certificate_request 
    # @param [Hash] opts the optional parameters
    # @return [Array<(PrincipalIdentity, Fixnum, Hash)>] PrincipalIdentity data, response status code and response headers
    def update_principal_identity_certificate_update_certificate_with_http_info(update_principal_identity_certificate_request, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.update_principal_identity_certificate_update_certificate ...'
      end
      # verify the required parameter 'update_principal_identity_certificate_request' is set
      if @api_client.config.client_side_validation && update_principal_identity_certificate_request.nil?
        fail ArgumentError, "Missing the required parameter 'update_principal_identity_certificate_request' when calling ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi.update_principal_identity_certificate_update_certificate"
      end
      # resource path
      local_var_path = '/trust-management/principal-identities?action=update_certificate'

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
      post_body = @api_client.object_to_http_body(update_principal_identity_certificate_request)
      auth_names = ['BasicAuth']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PrincipalIdentity')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ManagementPlaneApiNsxComponentAdministrationTrustManagementPrincipalIdentityApi#update_principal_identity_certificate_update_certificate\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
