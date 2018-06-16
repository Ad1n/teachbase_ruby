module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    extend Accessors
    attr_accessor_with_history :validations

    def validate(*validation_args)
      what_class = self.to_s.to_sym
      self.validations = {} if self.validations.nil?
      validations[what_class] = [] if validations[what_class].nil?
      case
      when validation_args[1] == :presence
        validations[what_class] << :presence
        validations[what_class] << validation_args[0]
      when validation_args[1] == :type
        validations[what_class] << :type
        validations[what_class] << validation_args[0]
        validations[what_class] << validation_args[2]
      when validation_args[1] == :format
        validations[what_class] << :format
        validations[what_class] << validation_args[0]
        validations[what_class] << validation_args[2]
      else
      "Wrong parameter: #{validation_args[1]}"
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandardError
      false
    end

    def validate!
      validate_params = self.class.validations
      name_class = self.class.validations.keys.first
      validate_params[name_class].each_with_index do |value, index|
        case
        when value == :presence
          raise 'Type attribute name please.' if
              instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym) == ""  \
              || instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym).nil?

        when value == :type
          raise "Wrong type - #{instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym).class}" if
              instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym).class != \
              validate_params[name_class][index + 2]
          raise "Wrong type !" if
              validate_params[name_class][index + 2] == String &&
              instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym).to_i.zero? == false &&
              instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym).to_i.class != \
              validate_params[name_class][index + 2]

        when value == :format
          regular_exp = validate_params[name_class][index + 2]
          raise "Format error!" if instance_variable_get("@#{validate_params[name_class][index + 1]}".to_sym) !~ \
          regular_exp

        else
          next
        end
      end
      true
    end

  end
end
