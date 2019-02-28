class Station
include InstanceCounter

  @@all = {}
  def self.all
   @@all.each { |name| puts name }
  end

  attr_accessor :trains,:name
  def initialize(name)
    @name = name
    @trains = []
    @@all[name] =self
    register_instance
  end

  def add_train(train) #add train
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def train_leave(train) #send train
    @trains.delete(train)
  end
end
