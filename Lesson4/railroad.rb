require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_pass.rb'

class RailRoad
  attr_accessor :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    loop do
      puts 'Привет! Это эмулятор железной дороги. Введите:'
      puts '1 - чтобы создать станцию, маршрут, поезд или вагон;'
      puts '2 - чтобы получить информацию об объектах;'
      puts '3 - чтобы внести изменения;'
      puts '0 - чтобы выйти из программы.'
      start_input = gets.chomp.to_i

      case start_input
      when 1
        create
      when 2
        info
      when 3
        change
      when 0
        break
      end
    end
  end

  def create
    puts 'Создать:'
    puts '1 - станцию;'
    puts '2 - маршрут;'
    puts '3 - поезд;'
    puts '4 - вагон;'
    puts '0 - возврат в начало'
    do_input = gets.chomp.to_i

    case do_input
    when 1
      puts 'Введите название станции:'
      name_station = STDIN.gets.chomp.capitalize

      @stations << Station.new(name_station)
      puts "Станция #{name_station} успешно создана."
    when 2
      puts 'Введите название маршрута:'
      name_route = STDIN.gets.chomp.capitalize

      puts 'Введите первую станцию маршрута:'
      first = STDIN.gets.chomp.capitalize

      @stations << Station.new(first)
      first = @stations.select { |station| first == station.name }

      puts 'Введите последнюю станцию маршрута:'
      last = STDIN.gets.chomp.capitalize

      @stations << Station.new(last)
      last = @stations.select { |station| last == station.name }

      @routes << Route.new(name_route, first[0], last[0])

      puts "Маршрут #{name_route} от станции #{first[0].name} до станции #{last[0].name} создан."
    when 3
      puts 'Введите номер поезда: '
      number = gets.to_i

      puts 'Введите тип поезда (1 - пассажирский, 2 - грузовой):'
      type = STDIN.gets.to_i

      if type == 1
        @trains << PassTrain.new(number, 'пассажирский')
        puts "Пассажирский поезд номер #{number} создан."
      elsif type == 2
        @trains << CargoTrain.new(number, 'грузовой')
        puts "Грузовой поезд номер #{number} создан."
      else
        puts 'Введите корректный тип поезда (1 - пассажирский, 2 - грузовой):'
        create
      end
    when 4
      puts 'Введите номер вагона: '
      number = gets.to_i

      puts 'Введите тип вагона (1 - пассажирский, 2 - грузовой):'
      type = STDIN.gets.to_i

      if type == 1
        @wagons << PassWagon.new(number, 'пассажирский')
        puts "Пассажирский вагон номер #{number} создан."
      elsif type == 2
        @wagons << CargoWagon.new(number, 'грузовой')
        puts "Грузовой вагон номер #{number} создан."
      else
        puts 'Введите корректный тип вагона (1 - пассажирский, 2 - грузовой).'
        create
      end
    when 0
      start
    end
  end

  def info
    puts 'Для получения информации введите:'
    puts '1 - маршруты;'
    puts '2 - поезда;'
    puts '3 - вагонаы;'
    puts '4 - станции;'
    puts '0 - в начало.'

    info_input = gets.to_i

    case info_input
    when 1
      show_routes
    when 2
      show_trains
    when 3
      show_wagons
    when 4
      show_stations
    when 0
      start
    end
  end

  def show_routes
    puts 'Не создано ни одного маршрута!' if @routes.empty?
    @routes.each &:show_stations # сперва в этих методах был блок, короткий способ подсказал рубокоп
  end

  def show_stations
    puts 'Не создано ни одной станции!' if @stations.empty?
    @stations.each &:show_trains
  end

  def show_trains
    puts 'Не создано ни одного поезда!' if @trains.empty?
    @trains.each &:info
  end

  def show_wagons
    puts 'Не создано ни одного вагона!' if @wagons.empty?
    @wagons.each &:info
  end

  def change
    puts 'Действия с объектами:'
    puts '1 - добавить станцию к маршруту;'
    puts '2 - удалить станцию из маршрута;'
    puts '3 - назначить маршрут поезду;'
    puts '4 - переместить поезд на следующую станцию маршрута;'
    puts '5 - переместить поезд на предыдущую станцию маршрута;'
    puts '6 - прицепить вагон к поезду;'
    puts '7 - отцепить вагон от поезда;'
    puts '8 - увеличиить скорость поезда;'
    puts '9 - остановить поезд;'
    puts '0 - вернуться в начало.'

    change = gets.to_i

    case change
    when 1
      add_station
    when 2
      delete_station
    when 3
      train_route
    when 4
      move_forward
    when 5
      move_back
    when 6
      add_wagons
    when 7
      delete_wagons
    when 8
      increase_speed
    when 9
      stop
    when 0
      start
    end
  end

  def add_station
    puts 'Введите название маршрута: '
    r = select_route
    puts 'Введите название станции: '
    name_station = STDIN.gets.chomp.capitalize
    @stations << Station.new(name_station)
    s = @stations.select { |station| name_station == station.name }
    r[0].add_station(s[0])
    puts "Станция #{s[0].name} добавлена в маршрут #{r[0].name_route}."
    r[0].show_stations
  end

  def delete_station
    puts 'Введите название маршрута: '
    r = select_route
    puts 'Введите название станции: '
    s = select_station
    r[0].delete_station(s[0])
    puts "Станция #{s[0].name} удалена из маршрута #{r[0].name_route}."
    r[0].show_stations
  end

  def select_route
    name_route = STDIN.gets.chomp.capitalize
    @routes.select { |route| name_route == route.name_route }
  end

  def select_station
    name_station = STDIN.gets.chomp.capitalize
    @stations.select { |station| name_station == station.name }
  end

  def select_train
    number = gets.to_i
    @trains.each.select { |train| number == train.number }
  end

  def select_wagon
    number = gets.to_i
    @wagons.each.select { |wagon| number == wagon.number }
  end

  def train_route
    puts 'Введите название маршрута:'
    r = select_route
    puts 'Введите номер поезда:'
    t = select_train
    t[0].route=(r[0])
    t[0].info
  end

  def move_forward
    puts 'Введите номер поезда:'
    t = select_train
    t[0].move_forward
    t[0].info
  end

  def move_back
    puts 'Введите номер поезда:'
    t = select_train

    t[0].move_back
    t[0].info
  end

  def add_wagons
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите номер вагона:'
    w = select_wagon

    t[0].add_wagons(w[0])
  end

  def delete_wagons
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите номер вагона:'
    w = select_wagon

    t[0].delete_wagons(w[0])
  end

  def increase_speed
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите, на сколько км/ч нужно увеличить скорость:'
    v = gets.to_i

    t[0].increase_speed(v)
  end

  def stop
    puts 'Введите номер поезда:'
    t = select_train

    t[0].stop
  end
end
