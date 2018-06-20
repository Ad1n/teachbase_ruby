module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    extend Accessors
    attr_accessor_with_history :validations

    def validate(*validation_args)
      self.validations = { name: validation_args[0], type: validation_args[1], options: validation_args[2] }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandardError
      false
    end

    def validate!
      validate_params = self.class.validations_history
      validate_params.each do |v|
        case
        when respond_to?(v[:name]) && v[:type] == :presence
          send("validate_#{v[:type]}!".to_sym, instance_variable_get("@#{v[:name]}".to_sym), v[:options])
        when respond_to?(v[:name]) && v[:type] == :format
          send("validate_#{v[:type]}!".to_sym, instance_variable_get("@#{v[:name]}".to_sym), v[:options])
        when respond_to?(v[:name]) && v[:type] == :type
          send("validate_#{v[:type]}!".to_sym, instance_variable_get("@#{v[:name]}".to_sym), v[:options])
        else
          next
        end
      end
      true
    end

    def validate_presence!(*values)
      raise "Can not be nil!" if values[0] == "" || values[0].nil?
    end

    def validate_format!(*values)
      regular_exp = values[1]
      raise "Format error!" if values[0] !~ regular_exp
    end

    def validate_type!(*values)
      raise "Type Error!" if values[0] != values[1]
    end

  end
end
