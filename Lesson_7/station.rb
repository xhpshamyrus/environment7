class Station
  STATION_NAME  = /^[a-zа-я]{3,}/i
  INVALID_STATION = "Наименование станции не должно содержать цифры и быть менее 3 букв!"

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
