require_relative 'manufacter'
require_relative 'validator'

class Wagon
  INCORRECT_NUMBER_WAGON = "Введите наименование в формате '*' или '**'".freeze
  WAGON_FORMAT = /^[\d]{1,2}$/.freeze
  NOT_SPACE = 'Нет свободного места'.freeze
  INCORRECT_VOLUME = 'Количество мест/объем не должно превышать 99!'.freeze
  MAX_VOLUME = 99

  include Manufacture
  include Validator

  attr_reader :type, :number, :occupied_volume, :total_volume

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

  protected

  def validate!
    raise INCORRECT_NUMBER_WAGON if @number !~ WAGON_FORMAT
    raise INCORRECT_VOLUME if @total_volume > MAX_VOLUME
  end
end
