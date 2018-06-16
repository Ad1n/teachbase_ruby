module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      array = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        array << value
      end
      define_method("#{name}_history".to_sym) { array }
    end
  end

  # Example of method strong_attr_accessor :name_attribute, Class_name
  def strong_attr_accessor(name_attribute, class_name)
    var_name = "@#{name_attribute}".to_sym
    define_method(name_attribute) { instance_variable_get(var_name) }
    define_method("#{name_attribute}=".to_sym) do |value|
      raise "Type class error: #{class_name}!" if self.class != class_name
      instance_variable_set(var_name, value)
    end
  end
end
