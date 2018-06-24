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
      p validate_params
      validate_params.each do |v|
        if respond_to?("validate_#{v[:type]}!".to_sym) && !instance_variable_get("@#{v[:name]}".to_sym).nil?
          send("validate_#{v[:type]}!".to_sym, instance_variable_get("@#{v[:name]}".to_sym), v[:options])
        else
          next
        end
      end
      true
    end

    def validate_presence!(name, _options)
      raise "Can not be nil!" if name == "" || name.nil?
    end

    def validate_format!(name, options)
      regular_exp = options
      raise "Format error!" if name !~ regular_exp
    end

    def validate_type!(name, options)
      raise "Type Error!" if name.class != options
    end

  end
end
