module MenuConstants
  MENU = <<-MENU.freeze
  -----------------------------------------------
  |                   RailRoad                  |
  -----------------------------------------------
  |Введите для                                  |
  |--> 1 создания станции                       |
  |--> 2 создания поезда                        |
  |--> 3 создания маршрута                      |
  |--> 4 создания вагона                        |
  |--> 5 добавления станции в маршрут           |
  |--> 6 удаления станции из маршрута           |
  |--> 7 назначения маршрута поезду             |
  |--> 8 прицепления или отцепления вагона      |
  |--> 9 перемещения поезда по маршруту         |
  |--> 10 отображения всех станций              |
  |--> 11 отображения поездов на станции        |
  |--> 12 отображения созданных маршрутов       |
  |--> 13 отображения созданных поездов         |
  |--> 14 Выход                                 |
  -----------------------------------------------
  MENU
  ENTER_TYPE_MENU_TRAIN = <<-MENU.freeze
  ----------------------
  |Выберите тип поезда:|
  |  1.Пассажирский    |
  |  2.Грузовой        |
  ----------------------
  MENU
  ENTER_TYPE_MENU_WAGON = <<-MENU.freeze
  ----------------------
  |Выберите тип вагона:|
  |  1.Пассажирский    |
  |  2.Грузовой        |
  ----------------------
  MENU
  ENTER_WAGON_ACTION_MENU = <<-MENU.freeze
  --------------------------------
  |Выберите действие над вагоном:|
  |  1.Прицепить                 |
  |  2.Отцепить                  |
  --------------------------------
  MENU
  ENTER_MOVED_TRAIN_MENU = <<-MENU.freeze
  ----------------------------------------
  |Введите для перемещения по маршруту:  |
  |  1. вперед                           |
  |  2. назад                            |
  ----------------------------------------
  MENU

  ENTER_FIRST_STATION = "Укажите номер начальной станции из списка"
  ENTER_LAST_STATION = "Укажите номер конечной станции из списка"
  ROUTE_CREATED = "Маршрут создан"
  CHOOSE_NUMBER_ROUTE = "Выберите порядковый номер маршрута:"
  CHOOSE_NUMBER_STATION = "Выберите порядковый номер станции:"
  STATION_ADDED_TO_ROUTE = "Станция добавлена в маршрут"
  ROUTES = "#{@routes}"
  NEEDED_TWO_STATIONS = "В маршруте должно быть не менее 2х станций"
  STATION_DELETED = "Станция удалена"
  ROUTE_ADEDED_TO_TRAIN = "Маршрут назначен поезду"
  TRAINS = "#{@trains}"
  WRONG_TYPE = "Тип вагона не подходит к поезду!"
  WAGON_ATTACHED = "Вагон прицеплен"
  WAGON_DETACHED = "Вагон отцеплен"
  TRAIN_MOVED_AHEAD = "Поезд перемещен по маршруту вперед"
  TRAIN_MOVED_BACK = "Поезд перемещен по маршруту назад"
  WAGON_CREATED ="Вагон создан"
  CHOOSE_WAGON_NUMBER = "Введите порядковый номер вагона из списка"
  ENTER_WAGON_NUMBER = "Введите номер вагона"
  CHOOSE_TRAIN_NUMBER = "Выберите поезд из списка"
  ASK_STATION_NAME = "Введите название станции"
  STATION_CREATED = "Станция создана"
  TRAIN_CREATED = "Позд создан"
  ENTER_TRAIN_NUMBER = "Введите номер поезда"
  INVALID_INDEX = "Неверный выбор!"
  INVALID_STAION = "Станции не могут совпадать!"
  TRAIN_STOPPED_FOR_ATTACHED = "Поезд остановлен для прицепления вагона."
  TRAIN_STOPPED = "Поезд остановлен"
  INVALID_STAION_NAME = "Название не может быть пустым!"
  INVALID_TYPE = "Указан неверный тип!"
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i
  WAGON_FORMAT  = /^[\d]{1,2}$/
  STATION_NAME  = /^[a-zа-я]{3,}/i
  INCORRECT_NUMBER = "Неверый ввод, введите наименование в формате '***'-'**' или '*****'"
  INVALID_STATION = "Наименование станции не должно содержать цифры и быть менее 3 букв!"
  INCORRECT_NUMBER_WAGON = "Неверный ввод, введите наименование в формате '*' или '**'"
  NOT_ACCEPT = "Необходимо назначить маршрут для перемещения!"
end

