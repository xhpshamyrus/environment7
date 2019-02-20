require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'

class Menu

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def interface
    loop do
      puts "  --------------------------------------------------  "
      puts "  |                   RailRoad                     |  "
      puts "  --------------------------------------------------  "
      puts "Введите для "
      puts "--> 1 создания станции"
      puts "--> 2 создания поезда"
      puts "--> 3 создания маршрута"
      puts "--> 4 создания вагона"
      puts "--> 5 добавления станции в маршрут"
      puts "--> 6 удаления станции из маршрута"
      puts "--> 7 назначения маршрута поезду"
      puts "--> 8 прицепления или отцепления вагона"
      puts "--> 9 перемещения поезда по маршруту"
      puts "--> 10 отображения всех станций"
      puts "--> 11 отображения поездов на станции"
      puts "--> 12 отображения созданных маршрутов"
      puts "--> 13 отображения созданных поездов"
      puts "--> 14 Выход"
      num = gets.chomp
      choice(num.to_i)
    end
  end

  def choice(num)
    case num
      when 1 then
        create_station
      when 2 then
        create_train
      when 3 then
        create_route
      when 4 then
        create_wagon
      when 5 then
        add_station_to_route
      when 6 then
        del_station_from_route
      when 7 then
        set_route
      when 8 then
        train_consist
      when 9 then
        move_train
      when 10 then
        list_stations
      when 11 then
        trains_on_station
      when 12 then
        list_routes
      when 13 then
        list_trains
      when 14 then abort "Have a nice day!"
    end
  end

  def create_station
    puts "Введите название станции"
    name_station = gets.chomp
    @stations << Station.new(name_station)
    puts "Станция #{name_station} создана"
  end

  def create_train
    puts "Введите номер поезда: "
    number = gets.chomp
    puts "Выберите тип поезда: "
    puts "1 - пассажирский"
    puts "2 - грузовой"
    option = gets.to_i
    case option
    when 1 then
      @trains << PassangerTrain.new(number)
    puts "Пассажирский позд №#{number} создан"
    when 2 then
      @trains << CargoTrain.new(number)
    puts "Грузовой поезд №#{number} создан"
    else
      create_train
    end
  end

  def create_route
    list_stations
    puts "Укажите номер начальной станции из списка"
    first_station = gets.to_i
    puts "Укажите номер конечной станции из списка"
    last_station = gets.to_i

    @routes << Route.new(@stations[first_station - 1], @stations[last_station - 1])
    a =  @stations[first_station - 1].name
    b =  @stations[last_station - 1].name
    puts "Маршрут: #{a} -> #{b} создан"
  end

  def add_station_to_route
    list_routes
    puts "Выберите порядковый номер маршрута:"
    id_route = gets.to_i - 1
    list_stations
    puts "Введите порядковый номер станции"
    id_station = gets.to_i - 1
    @routes[id_route].add_station(@stations[id_station])
    puts "#{@routes}"
    puts "Станция добавлена в маршрут"
  end

  def del_station_from_route
    list_routes
    puts "Выберите номер маршрута, из которого необходимо удалить станцию"
    @current_route = @routes[gets.to_i - 1]
    list_stations_in_route
    puts "Выберите порядковый номер станции для удаления:"
    del = @current_route.stations[gets.to_i - 1]
  if @current_route.stations.size == 2
    puts "В маршруте должно быть не менее 2х станций"
  else
    @current_route.stations.delete(del)
    list_stations_in_route
    puts "#{@routes}"
    puts "Станция удалена из маршрута"
    end
  end

  def set_route
    list_trains
    puts "Введите порядковий номер поезда:"
    id_train = gets.to_i - 1
    list_routes
    puts "Введите порядковый номер маршрута:"
    id_route = gets.to_i - 1
    @trains[id_train].accept_route(@routes[id_route])
    puts "#{@trains}"
    puts "Маршрут назначен поезду"
  end

  def create_wagon
    puts "Выберите тип вагона"
    puts "1 Пассажирский"
    puts "2 Грузовой"
    type = gets.to_i
    case type
    when 1 then
      puts "Введите номер вагона"
      number = gets.to_i
      @wagons << PassWagon.new(number)
      puts "Пассажирский вагон #{number} создан"
    when 2 then
      puts "Введите номер вагона"
      number = gets.to_i
      @wagons << CargoWagon.new(number)
      puts "Грузовой вагон #{number} создан"
    else
      create_wagon
    end
  end

  def train_consist
    puts "1 - Прицепить вагон к поезду"
    puts "2 - Отцепить вагон"
    wag = gets.to_i
    list_trains
    puts "Необходимо ввести порядковый номер поезда из списка"
    id_train = gets.to_i - 1
    list_wagons
    puts "Необходимо ввести порядковый номер вагона из списка"
    id_wagon = gets.to_i - 1
    case wag
    when 1 then
      if @trains[id_train].type == @wagons[id_wagon].type
         @trains[id_train].attach_wagon(@wagons[id_wagon])
        puts "Вагон прицеплен"
      else
        puts "Тип вагона не подходит к поезду"
      end
    when 2 then
      @trains[id_train].detach_wagon(@wagons[id_wagon])
      puts @trains
      puts "Вагон отцеплен"
    else
      train_consist
    end
  end

  def move_train
    list_trains
    puts "Введите номер поезда"
    id_train = gets.to_i - 1
    puts "Введите 1 для перемещения поезда по маршруту вперед"
    puts "Введите 2 для перемещения поезда по маршруту назад"
    move = gets.to_i
    case move
    when 1 then
      @trains[id_train].moving_ahead puts "Поезд перемещен по маршруту вперед"
    when 2 then
      @trains[id_train].moving_back puts "Поезд перемещен по маршруту назад"
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
    puts "Введите порядковый номер станции"
    id_station = gets.to_i - 1
    @stations[id_station].list_trains
  end

  def list_wagons_in_train
    puts "Введите порядковый номер поезда"
    id_tr_wag = gets.to_i -1
    @trains[id_tr_wag].list_wagons
  end

  def list_stations_in_route
    @current_route.list_stations
  end
end
