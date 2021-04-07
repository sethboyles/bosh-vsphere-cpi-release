=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'date'

module NSXT
  class Ipv4Header
    # The source ip address.
    attr_accessor :src_ip

    # IP flags
    attr_accessor :flags

    # The destination ip address.
    attr_accessor :dst_ip

    # This is used together with src_ip to calculate dst_ip for broadcast when dst_ip is not given; not used in all other cases.
    attr_accessor :src_subnet_prefix_len

    # Time to live (ttl)
    attr_accessor :ttl

    # IP protocol - defaults to ICMP
    attr_accessor :protocol

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'src_ip' => :'src_ip',
        :'flags' => :'flags',
        :'dst_ip' => :'dst_ip',
        :'src_subnet_prefix_len' => :'src_subnet_prefix_len',
        :'ttl' => :'ttl',
        :'protocol' => :'protocol'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'src_ip' => :'String',
        :'flags' => :'Integer',
        :'dst_ip' => :'String',
        :'src_subnet_prefix_len' => :'Integer',
        :'ttl' => :'Integer',
        :'protocol' => :'Integer'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      if attributes.has_key?(:'src_ip')
        self.src_ip = attributes[:'src_ip']
      end

      if attributes.has_key?(:'flags')
        self.flags = attributes[:'flags']
      else
        self.flags = 0
      end

      if attributes.has_key?(:'dst_ip')
        self.dst_ip = attributes[:'dst_ip']
      end

      if attributes.has_key?(:'src_subnet_prefix_len')
        self.src_subnet_prefix_len = attributes[:'src_subnet_prefix_len']
      end

      if attributes.has_key?(:'ttl')
        self.ttl = attributes[:'ttl']
      else
        self.ttl = 64
      end

      if attributes.has_key?(:'protocol')
        self.protocol = attributes[:'protocol']
      else
        self.protocol = 1
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if !@flags.nil? && @flags > 8
        invalid_properties.push('invalid value for "flags", must be smaller than or equal to 8.')
      end

      if !@flags.nil? && @flags < 0
        invalid_properties.push('invalid value for "flags", must be greater than or equal to 0.')
      end

      if !@src_subnet_prefix_len.nil? && @src_subnet_prefix_len > 32
        invalid_properties.push('invalid value for "src_subnet_prefix_len", must be smaller than or equal to 32.')
      end

      if !@src_subnet_prefix_len.nil? && @src_subnet_prefix_len < 1
        invalid_properties.push('invalid value for "src_subnet_prefix_len", must be greater than or equal to 1.')
      end

      if !@ttl.nil? && @ttl > 255
        invalid_properties.push('invalid value for "ttl", must be smaller than or equal to 255.')
      end

      if !@ttl.nil? && @ttl < 0
        invalid_properties.push('invalid value for "ttl", must be greater than or equal to 0.')
      end

      if !@protocol.nil? && @protocol > 255
        invalid_properties.push('invalid value for "protocol", must be smaller than or equal to 255.')
      end

      if !@protocol.nil? && @protocol < 0
        invalid_properties.push('invalid value for "protocol", must be greater than or equal to 0.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if !@flags.nil? && @flags > 8
      return false if !@flags.nil? && @flags < 0
      return false if !@src_subnet_prefix_len.nil? && @src_subnet_prefix_len > 32
      return false if !@src_subnet_prefix_len.nil? && @src_subnet_prefix_len < 1
      return false if !@ttl.nil? && @ttl > 255
      return false if !@ttl.nil? && @ttl < 0
      return false if !@protocol.nil? && @protocol > 255
      return false if !@protocol.nil? && @protocol < 0
      true
    end

    # Custom attribute writer method with validation
    # @param [Object] flags Value to be assigned
    def flags=(flags)
      if !flags.nil? && flags > 8
        fail ArgumentError, 'invalid value for "flags", must be smaller than or equal to 8.'
      end

      if !flags.nil? && flags < 0
        fail ArgumentError, 'invalid value for "flags", must be greater than or equal to 0.'
      end

      @flags = flags
    end

    # Custom attribute writer method with validation
    # @param [Object] src_subnet_prefix_len Value to be assigned
    def src_subnet_prefix_len=(src_subnet_prefix_len)
      if !src_subnet_prefix_len.nil? && src_subnet_prefix_len > 32
        fail ArgumentError, 'invalid value for "src_subnet_prefix_len", must be smaller than or equal to 32.'
      end

      if !src_subnet_prefix_len.nil? && src_subnet_prefix_len < 1
        fail ArgumentError, 'invalid value for "src_subnet_prefix_len", must be greater than or equal to 1.'
      end

      @src_subnet_prefix_len = src_subnet_prefix_len
    end

    # Custom attribute writer method with validation
    # @param [Object] ttl Value to be assigned
    def ttl=(ttl)
      if !ttl.nil? && ttl > 255
        fail ArgumentError, 'invalid value for "ttl", must be smaller than or equal to 255.'
      end

      if !ttl.nil? && ttl < 0
        fail ArgumentError, 'invalid value for "ttl", must be greater than or equal to 0.'
      end

      @ttl = ttl
    end

    # Custom attribute writer method with validation
    # @param [Object] protocol Value to be assigned
    def protocol=(protocol)
      if !protocol.nil? && protocol > 255
        fail ArgumentError, 'invalid value for "protocol", must be smaller than or equal to 255.'
      end

      if !protocol.nil? && protocol < 0
        fail ArgumentError, 'invalid value for "protocol", must be greater than or equal to 0.'
      end

      @protocol = protocol
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          src_ip == o.src_ip &&
          flags == o.flags &&
          dst_ip == o.dst_ip &&
          src_subnet_prefix_len == o.src_subnet_prefix_len &&
          ttl == o.ttl &&
          protocol == o.protocol
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [src_ip, flags, dst_ip, src_subnet_prefix_len, ttl, protocol].hash
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
