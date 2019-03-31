module Accessors

  def attr_accessor_with_history(*names)
    names.each do |name|

      variable = "@#{name}".to_sym  # var
      variable_history = "@#{name}_history".to_sym  #needed for collect history of var


      define_method(name) { instance_variable_get(variable) }

      define_method("@#{name}".to_sym) do |value|
        previous_value = instance_variable_get(variable) # get current value
        instance_variable_set(variable, value) # set new value
        if instance_variable_get(variable_history)
          instance_variable_get(variable_history) << previous_value #add previous value
        else
          instance_variable_set(variable_history, []) # array for history
        end
      end

      define_method("#{name}_history") { instance_variable_get(variable_history) }
      end
    end

  def strong_attr_accessor(name, type)
    variable = "@#{name}".to_sym

    define_method(name) { instance_variable_get(variable) }

    define_method("@#{name}".to_sym) do |value|
      raise ("Неверный тип #{name}. Необходим: #{type}") unless value.is_a?(type)
      instance_variable_set(variable, value)
    end
  end
end
