class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train) #add train
    @trains << train
  end

  def list_trains #show trains
    @trains.each { |train| puts train }
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def train_leave(train) #send train
    @trains.delete(train)
  end
end
