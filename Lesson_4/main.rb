require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'const.rb'

class Menu
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def interface
    loop do
      puts MENU
      num = gets.chomp
      choice(num.to_i)
    end
  end

  def choice(num)
    case num
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then create_wagon
      when 5 then add_station_to_route
      when 6 then del_station_from_route
      when 7 then set_route
      when 8 then train_consist
      when 9 then move_train
      when 10 then list_stations
      when 11 then trains_on_station
      when 12 then list_routes
      when 13 then list_trains
      when 14 then abort "Have a nice day!"
    end
  end

  def create_station
    puts ASK_STATION_NAME
    name_station = gets.chomp
    @stations << Station.new(name_station)
    puts STATION_CREATED
  end

  def create_train
    puts ENTER_TRAIN_NUMBER
    number = gets.chomp
    puts ENTER_TYPE_MENU_TRAIN
    option = gets.to_i
    case option
    when 1 then @trains << PassangerTrain.new(number)
    puts PASSANGER_TRAIN_CREATED
    when 2 then @trains << CargoTrain.new(number)
    puts CARGO_TRAIN_CREATED
    else
    create_train
    end
  end

  def select_from_array(array)
    index = gets.to_i
    array[index - 1]
  end

  def create_route
    list_stations
    puts ENTER_FIRST_STATION
    first_station = select_from_array(@stations)
    puts ENTER_LAST_STATION
    last_station = select_from_array(@stations)
    return puts (INVALID_INDEX) if first_station.nil? || last_station.nil?
    return puts (INVALID_STAION) if first_station == last_station
    @routes << Route.new(first_station, last_station)
    puts ROUTE_CREATED
  end

  def add_station_to_route
    list_routes
    puts CHOOSE_NUMBER_ROUTE
    @id_route = select_from_array(@routes)
    list_stations
    puts CHOOSE_NUMBER_STATION
    @id_station = select_from_array(@stations)
    return puts (INVALID_INDEX) if @id_route.nil? || @id_station.nil?
    @id_route.add_station(@id_station)
    puts STATION_ADDED_TO_ROUTE
  end

  def del_station_from_route
    list_routes
    puts CHOOSE_NUMBER_ROUTE
    @id_route = select_from_array(@routes)
    list_stations_in_route
    puts CHOOSE_NUMBER_STATION
    @station_in_route = select_from_array(@id_route.stations)
    return puts (INVALID_INDEX) if @id_route.nil? || station_in_route.nil?
    return puts (NEEDED_TWO_STATIONS) if @id_route.stations.size == 2
    @id_route.del_station(@station_in_route)
    list_stations_in_route
    puts STATION_DELETED
  end

  def set_route
    list_trains
    puts ENTER_TRAIN_NUMBER
    @id_train = select_from_array(@trains)
    list_routes
    puts CHOOSE_NUMBER_ROUTE
    @id_route = select_from_array(@routes)
    return puts (INVALID_INDEX) if @id_route.nil? || @id_train.nil?
    @id_train.accept_route(@id_route)
    puts ROUTE_ADEDED_TO_TRAIN
  end

  def create_wagon
    puts ENTER_TYPE_MENU_WAGON
    type = gets.to_i
    case type
    when 1
    puts ENTER_WAGON_NUMBER
    number = gets.to_i
    @wagons << PassWagon.new(number)
    puts WAGON_PASS_CREATED
    when 2
    puts ENTER_WAGON_NUMBER
    number = gets.to_i
    @wagons << CargoWagon.new(number)
    puts WAGON_CARGO_CREATED
    else
    create_wagon
    end
  end

  def train_consist
    puts ENTER_WAGON_ACTION_MENU
    wagon_consist = gets.to_i
    list_trains
    puts CHOOSE_TRAIN_NUMBER
    @id_train = select_from_array(@trains)
    list_wagons
    puts CHOOSE_WAGON_NUMBER
    @id_wagon = select_from_array(@wagons)
    case wagon_consist
    when 1
    #return puts WRONG_TYPE if @id_train.type != @id_wagon.type
    @id_train.attach_wagon(@id_wagon, @id_train)
    when 2
    @id_train.detach_wagon(@id_wagon)
    else
    train_consist
    end
  end

  def move_train
    list_trains
    puts ENTER_TRAIN_NUMBER
    @id_train = select_from_array(@trains)
    puts ENTER_MOVED_TRAIN_MENU
    move_train = gets.to_i
    return puts (INVALID_INDEX) if @id_train.nil?
    case move_train
    when 1
    @id_train.moving_ahead puts TRAIN_MOVED_AHEAD
    when 2
    @id_train.moving_back puts TRAIN_MOVED_BACK
    end
  end

  def list_stations
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def list_trains
    @trains.each_with_index { |train,index| puts "#{index + 1} #{train.number} #{train.type}" }
  end

  def list_wagons
    @wagons.each_with_index { |wagon, index| puts "#{index + 1} #{wagon.number} #{wagon.type}" }
  end

  def list_routes
    @routes.each_with_index { |route, index| puts "#{index + 1} #{route}" }
  end

  def trains_on_station
    list_stations
    puts CHOOSE_NUMBER_STATION
    id_station = select_from_array(@stations)
    id_station.list_trains
  end

  def list_stations_in_route
    @id_route.list_stations
  end
end
