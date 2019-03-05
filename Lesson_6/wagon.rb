require_relative 'manufacter'
require_relative 'validator'
require_relative 'constants'

class Wagon
  include Manufacture
  include Validator
  include MenuConstants

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
