class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def list_stations
    @stations.each { |station| puts station.name }
  end
end
