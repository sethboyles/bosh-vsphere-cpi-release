=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'date'

module NSXT
  class BFDDiagnosticCount
    # Number of tunnels with concatenated path down diagnostic message
    attr_accessor :concatenated_path_down_count

    # Number of tunnels with administratively down diagnostic message
    attr_accessor :administratively_down_count

    # Number of tunnels with no diagnostic
    attr_accessor :no_diagnostic_count

    # Number of tunnels with path down diagnostic message
    attr_accessor :path_down_count

    # Number of tunnels with reverse concatenated path down diagnostic message
    attr_accessor :reverse_concatenated_path_down_count

    # Number of tunnels neighbor signaled session down
    attr_accessor :neighbor_signaled_session_down_count

    # Number of tunnels with control detection time expired diagnostic message
    attr_accessor :control_detection_time_expired_count

    # Number of tunnels with echo function failed diagnostic message
    attr_accessor :echo_function_failed_count

    # Number of tunnels with forwarding plane reset diagnostic message
    attr_accessor :forwarding_plane_reset_count

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'concatenated_path_down_count' => :'concatenated_path_down_count',
        :'administratively_down_count' => :'administratively_down_count',
        :'no_diagnostic_count' => :'no_diagnostic_count',
        :'path_down_count' => :'path_down_count',
        :'reverse_concatenated_path_down_count' => :'reverse_concatenated_path_down_count',
        :'neighbor_signaled_session_down_count' => :'neighbor_signaled_session_down_count',
        :'control_detection_time_expired_count' => :'control_detection_time_expired_count',
        :'echo_function_failed_count' => :'echo_function_failed_count',
        :'forwarding_plane_reset_count' => :'forwarding_plane_reset_count'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'concatenated_path_down_count' => :'Integer',
        :'administratively_down_count' => :'Integer',
        :'no_diagnostic_count' => :'Integer',
        :'path_down_count' => :'Integer',
        :'reverse_concatenated_path_down_count' => :'Integer',
        :'neighbor_signaled_session_down_count' => :'Integer',
        :'control_detection_time_expired_count' => :'Integer',
        :'echo_function_failed_count' => :'Integer',
        :'forwarding_plane_reset_count' => :'Integer'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      if attributes.has_key?(:'concatenated_path_down_count')
        self.concatenated_path_down_count = attributes[:'concatenated_path_down_count']
      end

      if attributes.has_key?(:'administratively_down_count')
        self.administratively_down_count = attributes[:'administratively_down_count']
      end

      if attributes.has_key?(:'no_diagnostic_count')
        self.no_diagnostic_count = attributes[:'no_diagnostic_count']
      end

      if attributes.has_key?(:'path_down_count')
        self.path_down_count = attributes[:'path_down_count']
      end

      if attributes.has_key?(:'reverse_concatenated_path_down_count')
        self.reverse_concatenated_path_down_count = attributes[:'reverse_concatenated_path_down_count']
      end

      if attributes.has_key?(:'neighbor_signaled_session_down_count')
        self.neighbor_signaled_session_down_count = attributes[:'neighbor_signaled_session_down_count']
      end

      if attributes.has_key?(:'control_detection_time_expired_count')
        self.control_detection_time_expired_count = attributes[:'control_detection_time_expired_count']
      end

      if attributes.has_key?(:'echo_function_failed_count')
        self.echo_function_failed_count = attributes[:'echo_function_failed_count']
      end

      if attributes.has_key?(:'forwarding_plane_reset_count')
        self.forwarding_plane_reset_count = attributes[:'forwarding_plane_reset_count']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          concatenated_path_down_count == o.concatenated_path_down_count &&
          administratively_down_count == o.administratively_down_count &&
          no_diagnostic_count == o.no_diagnostic_count &&
          path_down_count == o.path_down_count &&
          reverse_concatenated_path_down_count == o.reverse_concatenated_path_down_count &&
          neighbor_signaled_session_down_count == o.neighbor_signaled_session_down_count &&
          control_detection_time_expired_count == o.control_detection_time_expired_count &&
          echo_function_failed_count == o.echo_function_failed_count &&
          forwarding_plane_reset_count == o.forwarding_plane_reset_count
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [concatenated_path_down_count, administratively_down_count, no_diagnostic_count, path_down_count, reverse_concatenated_path_down_count, neighbor_signaled_session_down_count, control_detection_time_expired_count, echo_function_failed_count, forwarding_plane_reset_count].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = NSXT.const_get(type).new
        temp_model.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end
end
