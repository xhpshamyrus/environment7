require_relative 'manufacter'
class Wagon
  include Manufacture
  attr_reader :type, :number
  def initialize(number, type)
    @number = number
    @type = type
  end
end
