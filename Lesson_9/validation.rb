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
    MAX_VOLUME = 99
    NOT_EMPTY_VALUE = 'Значение не может быть пустым!'.freeze
    INCORRECT_FORMAT = 'Неверный формат ввода!'.freeze
    INCORRECT_TYPE = 'Неверный тип!'.freeze

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def presence(value, _)
      raise NOT_EMPTY_VALUE if value.nil? || value == ''
    end

    def format(value, format)
      raise INCORRECT_FORMAT if value !~ format
    end

    def type(value, type)
      raise INCORRECT_TYPE unless value.is_a?(type)
    end

    def volume(total_volume, _)
      raise INCORRECT_VOLUME if @total_volume > MAX_VOLUME
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:attribute]}".to_sym)
        def_name = validation[:type_valid].to_sym
        send(def_name, value, validation[:params])
      end
    end
  end
end




