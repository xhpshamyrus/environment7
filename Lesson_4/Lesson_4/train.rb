class Train
  attr_reader :number, :type, :route, :speed, :wagons

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def go(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    stop
    puts "Поезд остановлен для прицепления вагона"
    @wagons << wagon
  end

  def detach_wagon(wagon)
    stop
    puts "Поезд остановлен, для отцепления вагона"
    @wagons.delete(wagon) if @wagons.include?(wagon)
  end

  def accept_route(route)
    @route = route
    @current_station = 0
    route.stations[@current_station].add_train(self)
  end

  def moving_ahead(train)
    return unless next_station

    current_station.train_leave(self)
    @current_station += 1
    current_station.add_train(self)
  end

  def moving_back(train)
    return unless previous_station

    current_station.train_leave(self)
    @current_station -= 1
    current_station.add_train(self)
  end

  protected #Методы могут вызываться внутри класса через методы родственных объектов.

  attr_accessor :current_station

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
