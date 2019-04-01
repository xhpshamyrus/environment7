module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, type_valid, params = nil)
      @validations ||= []
      @validations << { attribute: attribute,
                        type_valid: type_valid,
                        params: params }
    end
  end

  module InstanceMethods
    INCORRECT_VOLUME = 'Количество мест/объем не должно превышать 99!'.freeze
    #NOT_EMPTY_VALUE = 'Значение не может быть пустым!'.freeze
    INCORRECT_FORMAT = 'Неверный формат ввода!'.freeze
    INCORRECT_TYPE = 'Неверный тип!'.freeze
    #MAX_VOLUME = 99

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate_presence(value, _)
      raise NOT_EMPTY_VALUE if value.nil? || value == ''
    end

    def validate_format(value, format)
      raise INCORRECT_FORMAT if value !~ format
    end

    def validate_type(value, type)
      raise INCORRECT_TYPE unless value.is_a?(type)
    end

    def validate_max_value(value, max_value)
      raise "Значение не может быть больше #{max_value}" if value > max_value
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:attribute]}".to_sym)
        validation_method = "#{validation[:type_valid]}".to_sym
        send(validation_method, value, validation[:params])
      end
    end
  end
end




