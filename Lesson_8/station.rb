class Station
  STATION_NAME = /^[a-zа-я]{3,}/i.freeze
  INVALID_STATION = 'Название не может быть менее 3 букв!'.freeze

  include InstanceCounter
  include Validator

  @@all = []

  def self.all
    @@all
  end

  attr_accessor :trains, :name

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

  protected

  def validate!
    raise INVALID_STATION if @name !~ STATION_NAME
  end
end
