require_relative 'manufacter'
require_relative 'validator'

class Wagon
  INCORRECT_NUMBER_WAGON = "Неверный ввод, введите наименование в формате '*' или '**'"
  WAGON_FORMAT  = /^[\d]{1,2}$/

  include Manufacture
  include Validator

  attr_reader :number, :type

  def initialize(number)
    @number = number
    validate!
    @type = type
  end

  protected

  def validate!
    raise INCORRECT_NUMBER_WAGON if @number !~ WAGON_FORMAT
    true
  end
end
