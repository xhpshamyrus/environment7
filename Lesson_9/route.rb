require_relative 'instance_counter'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end

  def to_s
    [stations.first.name, stations.last.name].join(' - ')
  end
end
