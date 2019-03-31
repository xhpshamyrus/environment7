require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  STATION_NAME = /^[a-zа-я]{3,}/i.freeze
  INVALID_STATION = 'Название не может быть менее 3 букв!'.freeze

  @@all = []

  def self.all
    @@all
  end

  attr_accessor_with_history :trains, :name

  validate :name, :validate_presence
  validate :name, :validate_format, STATION_NAME

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def train_leave(train)
    @trains.delete(train)
  end

  def each_train
    trains.each { |train| yield(train) }
  end
end
