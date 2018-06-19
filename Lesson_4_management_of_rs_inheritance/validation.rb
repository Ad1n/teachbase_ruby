module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    extend Accessors
    attr_accessor_with_history :validations

    def validate(*validation_args)
      self.validations = [validation_args[0], validation_args[1], validation_args[2]]
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
        when respond_to?(v[0]) && v[1] == :presence
          send :validate_presence!, v
        when respond_to?(v[0]) && v[1] == :format
          send :validate_format!, v
        when respond_to?(v[0]) && v[1] == :type
          send :validate_type!, v
        else
          next
        end
      end
      true
    end

    def validate_presence!(args)
      raise "Can not be nil!" if instance_variable_get("@#{args[0]}".to_sym) == "" || \
                                 instance_variable_get("@#{args[0]}".to_sym).nil?
    end

    def validate_format!(args)
      regular_exp = args[2]
      raise "Format error!" if instance_variable_get("@#{args[0].to_s}") !~ regular_exp
    end

    def validate_type!(args)
      raise "Type Error!" if instance_variable_get("@#{args[0].to_s}").class != args[2]
    end

  end
end
