require_relative 'manufacter'
require_relative 'accessors'
require_relative 'validation'

class Wagon
  include Manufacture
  include Validation
  extend Accessors

  INCORRECT_NUMBER_WAGON = "Введите наименование в формате '*' или '**'".freeze
  WAGON_FORMAT = /^[\d]{1,2}$/.freeze
  NOT_SPACE = 'Нет свободного места'.freeze

  attr_accessor_with_history :type, :number, :occupied_volume, :total_volume

  def initialize(number, total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
    @number = number
    validate!
  end

  def free_volume
    @total_volume - @occupied_volume
  end

  def take_volume(take_volume)
    raise NOT_SPACE if take_volume > free_volume

    @occupied_volume += take_volume
  end
end
