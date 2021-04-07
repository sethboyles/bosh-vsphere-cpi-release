=begin
#NSX-T Manager API

#VMware NSX-T Manager REST API

OpenAPI spec version: 2.5.1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.19

=end

require 'date'

module NSXT
  # Alarm in NSX that needs users' attention
  class Alarm
    # Sources emitting this alarm
    attr_accessor :sources

    # Alarm state
    attr_accessor :state

    # Alarm source component like nsx-manager, nsx-edge etc
    attr_accessor :source_comp

    # Severity of an Alarm
    attr_accessor :severity

    # Unique identifier(like UUID) for the node sending the Alarm
    attr_accessor :source_comp_id

    # Date and time in UTC of the Alarm
    attr_accessor :timestamp

    # Description of the Alarm
    attr_accessor :message

    # Unique identifier for an NSX Alarm
    attr_accessor :id

    # Alarm source sub component like nsx-mpa etc
    attr_accessor :source_subcomp

    class EnumAttributeValidator
      attr_reader :datatype
      attr_reader :allowable_values

      def initialize(datatype, allowable_values)
        @allowable_values = allowable_values.map do |value|
          case datatype.to_s
          when /Integer/i
            value.to_i
          when /Float/i
            value.to_f
          else
            value
          end
        end
      end

      def valid?(value)
        !value || allowable_values.include?(value)
      end
    end

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'sources' => :'sources',
        :'state' => :'state',
        :'source_comp' => :'source_comp',
        :'severity' => :'severity',
        :'source_comp_id' => :'source_comp_id',
        :'timestamp' => :'timestamp',
        :'message' => :'message',
        :'id' => :'id',
        :'source_subcomp' => :'source_subcomp'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'sources' => :'AlarmSource',
        :'state' => :'String',
        :'source_comp' => :'String',
        :'severity' => :'String',
        :'source_comp_id' => :'String',
        :'timestamp' => :'Integer',
        :'message' => :'String',
        :'id' => :'String',
        :'source_subcomp' => :'String'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      if attributes.has_key?(:'sources')
        self.sources = attributes[:'sources']
      end

      if attributes.has_key?(:'state')
        self.state = attributes[:'state']
      end

      if attributes.has_key?(:'source_comp')
        self.source_comp = attributes[:'source_comp']
      end

      if attributes.has_key?(:'severity')
        self.severity = attributes[:'severity']
      end

      if attributes.has_key?(:'source_comp_id')
        self.source_comp_id = attributes[:'source_comp_id']
      end

      if attributes.has_key?(:'timestamp')
        self.timestamp = attributes[:'timestamp']
      end

      if attributes.has_key?(:'message')
        self.message = attributes[:'message']
      end

      if attributes.has_key?(:'id')
        self.id = attributes[:'id']
      end

      if attributes.has_key?(:'source_subcomp')
        self.source_subcomp = attributes[:'source_subcomp']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @state.nil?
        invalid_properties.push('invalid value for "state", state cannot be nil.')
      end

      if @message.nil?
        invalid_properties.push('invalid value for "message", message cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @state.nil?
      state_validator = EnumAttributeValidator.new('String', ['UNKNOWN', 'ACTIVE', 'ACKNOWLEDGED', 'RESOLVED'])
      return false unless state_validator.valid?(@state)
      severity_validator = EnumAttributeValidator.new('String', ['UNKNOWN', 'MINOR', 'MAJOR', 'CRITICAL'])
      return false unless severity_validator.valid?(@severity)
      return false if @message.nil?
      true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] state Object to be assigned
    def state=(state)
      validator = EnumAttributeValidator.new('String', ['UNKNOWN', 'ACTIVE', 'ACKNOWLEDGED', 'RESOLVED'])
      unless validator.valid?(state)
        fail ArgumentError, 'invalid value for "state", must be one of #{validator.allowable_values}.'
      end
      @state = state
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] severity Object to be assigned
    def severity=(severity)
      validator = EnumAttributeValidator.new('String', ['UNKNOWN', 'MINOR', 'MAJOR', 'CRITICAL'])
      unless validator.valid?(severity)
        fail ArgumentError, 'invalid value for "severity", must be one of #{validator.allowable_values}.'
      end
      @severity = severity
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          sources == o.sources &&
          state == o.state &&
          source_comp == o.source_comp &&
          severity == o.severity &&
          source_comp_id == o.source_comp_id &&
          timestamp == o.timestamp &&
          message == o.message &&
          id == o.id &&
          source_subcomp == o.source_subcomp
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [sources, state, source_comp, severity, source_comp_id, timestamp, message, id, source_subcomp].hash
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
