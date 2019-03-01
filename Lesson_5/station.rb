class Station
  include InstanceCounter

  @@all = []

  def self.all
   @@all
  end

  attr_accessor :trains, :name

  def initialize(name)
    @name = name
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
end
