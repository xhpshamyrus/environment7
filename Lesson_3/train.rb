class Train
  attr_reader :number, :type, :wagons, :route, :current_station, :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type  #pass or freight
    @wagons = wagons
    @speed = 0
  end

  def go(speed)
    @speed += speed
  end

  def current_speed
    @speed
  end

  def stop
    @speed = 0
  end

  def attach_wagon
    @wagons += 1 if current_speed == 0
  end

  def detach_wagon
    @wagons -= 1 if current_speed == 0
  end

  def wagons_number
    @wagons
  end

  def accept_route(route) #set routing
    @route = route
    @current_station = 0
    route.stations[@current_station].add_train(self)
  end

  def moving_ahead
    return unless show_next

    current_station.train_leave(self)
    @current_station += 1
    current_station.add_train(self)
  end

  def moving_back
    return unless show_previous

    current_station.train_leave(self)
    @current_station -= 1
    current_station.add_train(self)
  end

  def show_previous
    route.stations[@current_station - 1]
  end

  def current_station
    route.stations[@current_station]
  end

  def show_next
    route.stations[@current_station + 1]
  end
end
