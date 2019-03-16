require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'menu_constants.rb'
require_relative 'validator.rb'

class Main
  include MenuConstants

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

  private

  def choice(num)
    case num
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then create_wagon
      when 5 then add_station_to_route
      when 6 then del_station_from_route
      when 7 then set_route
      when 8 then manage_train_wagons
      when 9 then move_train
      when 10 then list_stations
      when 11 then trains_on_station
      when 12 then list_routes
      when 13 then list_trains
      when 14 then list_wagon_seats
      when 15 then list_wagon_value
      when 16 then control_wagon
      when 17 then abort "Have a nice day!"
    end
  end

  def create_station
    puts ASK_STATION_NAME
    name_station = gets.chomp
    return puts INVALID_STAION_NAME if name_station.empty?
    @stations << Station.new(name_station)
    puts STATION_CREATED
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    puts ENTER_TYPE_MENU_TRAIN
    train_type =
      case gets.to_i
      when 1 then PassangerTrain
      when 2 then CargoTrain
      end
    puts ENTER_TRAIN_NUMBER
    number = gets.chomp
    return puts (INVALID_TYPE) if train_type.nil? #|| number.nil?
    @trains << train_type.new(number)
    puts TRAIN_CREATED
  rescue RuntimeError => e
    puts e.message
    retry
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
    route = select_from_array(@routes)
    list_stations
    puts CHOOSE_NUMBER_STATION
    station = select_from_array(@stations)
    return puts (INVALID_INDEX) if route.nil? || station.nil?
    route.add_station(station)
    puts STATION_ADDED_TO_ROUTE
  end

  def del_station_from_route
    list_routes
    puts CHOOSE_NUMBER_ROUTE
    @route = select_from_array(@routes)
    list_stations_in_route
    puts CHOOSE_NUMBER_STATION
    station_in_route = select_from_array(@route.stations)
    return puts (INVALID_INDEX) if @route.nil? || station_in_route.nil?
    return puts (NEEDED_TWO_STATIONS) if @route.stations.size == 2
    @route.del_station(station_in_route)
    list_stations_in_route
    puts STATION_DELETED
  end

  def set_route
    list_trains
    puts ENTER_TRAIN_NUMBER
    train = select_from_array(@trains)
    list_routes
    puts CHOOSE_NUMBER_ROUTE
    route = select_from_array(@routes)
    return puts (INVALID_INDEX) if route.nil? || train.nil?
    train.accept_route(route)
    puts ROUTE_ADEDED_TO_TRAIN
    puts "#{@routes}"
  end

  def create_wagon
    puts ENTER_TYPE_MENU_WAGON
    wagon_type =
      case gets.to_i
      when 1 then PassWagon
      when 2 then CargoWagon
      end
    if wagon_type == PassWagon
      puts ENTER_SEATS
      total_volume = gets.chomp
    elsif wagon_type == CargoWagon
      puts ENTER_VOLUME
      total_volume = gets.chomp
    end
    puts ENTER_WAGON_NUMBER
    number = gets.chomp
    return puts (INVALID_TYPE) if wagon_type.nil? #|| number.nil?
    @wagons << wagon_type.new(number, total_volume)
    puts WAGON_CREATED
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def manage_train_wagons
    puts ENTER_WAGON_ACTION_MENU
    wagon_action = gets.to_i
    list_trains
    puts CHOOSE_TRAIN_NUMBER
    train = select_from_array(@trains)
    list_wagons
    puts CHOOSE_WAGON_NUMBER
    wagon = select_from_array(@wagons)
    return puts (INVALID_INDEX) if train.nil? || wagon.nil?
    case wagon_action
    when 1
      if train.attach_wagon(wagon, train).nil?
        puts WRONG_TYPE
      else
        puts TRAIN_STOPPED, WAGON_ATTACHED
        puts "#{@trains}"
      end
    when 2
      train.detach_wagon(wagon)
      puts TRAIN_STOPPED, WAGON_DETACHED
      puts "#{@trains}"
    else
      manage_train_wagons
    end
  end

  def move_train
    list_trains
    puts ENTER_TRAIN_NUMBER
    train = select_from_array(@trains)
    puts ENTER_MOVED_TRAIN_MENU
    move_train = gets.to_i
    return puts (INVALID_INDEX) if train.nil?
    case move_train
    when 1
      train.moving_ahead
      puts TRAIN_MOVED_AHEAD
      #puts "#{@trains}"
    when 2
      train.moving_back
      puts TRAIN_MOVED_BACK
      #puts "#{@trains}"
    end
  end

  def control_wagon
    list_wagons
    puts CHOOSE_WAGON_NUMBER
    choosen_wagon = select_from_array(@wagons)
    return puts (INVALID_INDEX) if choosen_wagon.nil?
    if choosen_wagon.type == :passanger
      choosen_wagon.take_volume
      puts "Номер: #{choosen_wagon.number} Тип: #{choosen_wagon.type} Общее кол-во мест: #{choosen_wagon.total_volume} Кол-во занятых: #{choosen_wagon.occupied_volume}"
    elsif choosen_wagon.type == :cargo
      puts ENTER_VOLUME_PLACE
      volume = gets.to_f
      choosen_wagon.take_volume(volume)
      puts "Номер: #{choosen_wagon.number} Тип: #{choosen_wagon.type} Общий объем: #{choosen_wagon.total_volume} Занятый объем: #{choosen_wagon.occupied_volume}"
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def list_stations
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def list_trains
    @trains.each_with_index { |train, index| puts "#{index + 1} #{train.number} #{train.type}" }
  end

  def list_wagons
    @wagons.each_with_index { |wagon, index| puts "#{index + 1} Номер: #{wagon.number} Тип: #{wagon.type}" }
  end

  def list_wagon_seats
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}) Номер: #{wagon.number} Тип: #{wagon.type}  Общее кол-во мест: #{wagon.total_volume} Кол-во занятых: #{wagon.occupied_volume} Свободных мест: #{wagon.free_volume}" if wagon.type == :passanger }
  end

  def list_wagon_value
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}) Номер: #{wagon.number} Тип: #{wagon.type} Общий объём: #{wagon.total_volume} Занятый объем: #{wagon.occupied_volume} Свободный объем: #{wagon.free_volume}" if wagon.type == :cargo  }
  end

  def list_routes
    @routes.each_with_index { |route, index| puts "#{index + 1} #{route.to_s}" }
  end

  def trains_on_station
    list_stations
    puts CHOOSE_NUMBER_STATION
    station = select_from_array(@stations)
    return puts INVALID_INDEX if station.nil?
    puts station.trains
  end

  def list_stations_in_route
    @route.stations.each_with_index { |station, index | puts "#{index + 1} #{station.name}"}
  end
end
