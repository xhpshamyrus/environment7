require_relative 'manufacter'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i.freeze
  INCORRECT_NUMBER = "Введите в формате '***'-'**' или '*****'".freeze

  include Manufacture
  include InstanceCounter
  include Validation
  extend Accessors

  @@all_trains = {}

  def self.find(number)
    @@all_trains[number]
  end

  attr_accessor_with_history :type, :number, :route, :speed, :wagons

  validate :number, :validate_presence
  validate :number, :validate_format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@all_trains[@number] = self
    register_instance
  end

  def go(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon, train)
    return nil if train.type != wagon.type

    stop
    @wagons << wagon
  end

  def detach_wagon(wagon)
    stop
    @wagons.delete(wagon) if @wagons.include?(wagon)
  end

  def accept_route(route)
    @route = route
    @current_station = 0
    route.stations[@current_station].add_train(self)
  end

  def moving_ahead
    return unless next_station

    current_station.train_leave(self)
    @current_station += 1
    current_station.add_train(self)
  end

  def moving_back
    return unless previous_station

    current_station.train_leave(self)
    @current_station -= 1
    current_station.add_train(self)
  end

  def each_wagon_with_index
    wagons.each_with_index { |wagon, index| yield(index, wagon) }
  end

  protected # Методы вызываются внутри класса через методы родственных объектов.

  def previous_station
    route.stations[@current_station - 1]
  end

  def current_station
    route.stations[@current_station]
  end

  def next_station
    route.stations[@current_station + 1]
  end
end
