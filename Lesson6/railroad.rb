require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_pass.rb'
require_relative 'company_name.rb'
require_relative 'counter.rb'

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
      create_station
    when 2
      create_route
    when 3
      create_train
    when 4
      create_wagon
    when 0
      start
    end
  end

  def create_station
    begin
      puts 'Введите название станции:'
      name_station = STDIN.gets.chomp.capitalize

      @stations << Station.new(name_station)
      puts "Станция #{name_station} успешно создана."

      rescue => e
        puts e.message  
        retry
      end
  end

  def create_route
    begin
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

      rescue => e
        puts e.message  
        retry
      end

    puts "Маршрут #{name_route} от станции #{first[0].name} до станции #{last[0].name} создан."
  end

  def create_train
    begin
      puts 'Введите номер поезда: '
      number = gets.chomp

      puts 'Введите тип поезда (1 - пассажирский, 2 - грузовой):'
      type = STDIN.gets.to_i

      @trains << PassTrain.new(number) if type == 1  
      @trains << CargoTrain.new(number) if type == 2    
        
      rescue => e
        puts e.message  
        retry
      end

      if type == 1
        puts "Пассажирский поезд с номером #{number} создан."
      elsif type == 2
        puts "Грузовой поезд с номером #{number} создан."
      else
        puts 'Введите корректный тип поезда: 1 - пассажирский, 2 - грузовой.'
        create_train
      end
  end

  def create_wagon
    begin
      puts 'Введите номер вагона: '
      number = gets.chomp

      puts 'Введите тип вагона (1 - пассажирский, 2 - грузовой):'
      type = STDIN.gets.to_i

       @wagons << PassWagon.new(number) if type == 1
       @wagons << CargoWagon.new(number) if type == 2

    rescue => e
        puts e.message  
        retry
      end

    if type == 1 
      puts "Пассажирский вагон номер #{number} создан."
    elsif type == 2
      puts "Грузовой вагон номер #{number} создан."
    else
      puts 'Введите корректный тип вагона (1 - пассажирский, 2 - грузовой).'
      create
    end
  end

  def info
    puts 'Для получения информации введите:'
    puts '1 - маршруты;'
    puts '2 - поезда;'
    puts '3 - вагоны;'
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
    @routes.each do |route|
      puts "Маршрут #{route.name_route}: "
      route.stations.map.with_index(1) do |station, index|
        puts "Станция #{index}: #{station.name}. Поездов на станции: #{station.trains.size}."
      end
    end
  end

  def show_stations
    puts 'Не создано ни одной станции!' if @stations.empty?
    @stations.each do |station|
      puts "Станция #{station.name}."
      station.trains.each do |train|
        puts "Поезда на станции:"
        puts "Пассажирский поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'пассажирский'
        puts "Грузовой поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'грузовой'
      end
    end
  end

  def show_trains
    puts 'Не создано ни одного поезда!' if @trains.empty?
    @trains.each do |train|
      if train.route == nil
        puts "#{train.type.capitalize} поезд номер #{train.number} не прибыл на станцию, вагонов в поезде #{train.wagon_info.size}. Поезд движется со скоростью #{train.current_speed} км/ч."
      else
        train.info
      end
    end
  end

  def show_wagons
    puts 'Не создано ни одного вагона!' if @wagons.empty?
    @wagons.each do |wagon|
      if wagon.train == nil
        puts 'Вагон не прицеплен к поезду.'
      else
        puts "Вагон номер #{wagon.number} прицеплен к поезду #{wagon.train}."
      end
    end
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
  end

  def delete_station
    puts 'Введите название маршрута: '
    r = select_route
    puts 'Введите название станции: '
    s = select_station
    r[0].delete_station(s[0])
    puts "Станция #{s[0].name} удалена из маршрута #{r[0].name_route}."
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
    number = gets.chomp
    @trains.each.select { |train| number == train.number }
  end

  def select_wagon
    number = gets.chomp
    @wagons.each.select { |wagon| number == wagon.number }
  end

  def train_route
    puts 'Введите название маршрута:'
    r = select_route
    puts 'Введите номер поезда:'
    t = select_train
    t[0].route=(r[0])
    puts "#{t[0].type.capitalize} поезд номер #{t[0].number} находится на маршруте #{r[0].name_route} на станции #{r[0].first.name}."
  end

  def move_forward
    begin
      puts 'Введите номер поезда:'
      t = select_train

      t[0].move_forward

    rescue => e
      puts e.message  
    end

    t[0].info
  end

  def move_back
    begin
      puts 'Введите номер поезда:'
      t = select_train

      t[0].move_back

    rescue => e
      puts e.message
    end

    t[0].info
  end

  def add_wagons
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите номер вагона:'
    w = select_wagon

    if t[0].current_speed.zero?
      if w[0].type != t[0].type
        puts 'Вагон и поезд должны быть одного типа!'
      else
        t[0].add_wagons(w[0])
        puts "#{w[0].type.capitalize} вагон номер #{w[0].number} прицеплен к поезду номер #{t[0].number}."
      end
    else
      puts 'Нужно остановить поезд, прежде чем прицеплять или отцеплять вагоны!'
    end
  end

  def delete_wagons
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите номер вагона:'
    w = select_wagon

    if t[0].current_speed.zero?
      if w[0].type != t[0].type
        puts 'Вагон и поезд должны быть одного типа!'
      else
        t[0].delete_wagons(w[0])
        puts "#{w[0].type.capitalize} вагон номер #{w[0].number} отцеплен от поезда номер #{t[0].number}."
      end
    else
      puts 'Нужно остановить поезд, прежде чем прицеплять или отцеплять вагоны!'
    end
  end

  def increase_speed
    puts 'Введите номер поезда:'
    t = select_train

    puts 'Введите, на сколько км/ч нужно увеличить скорость:'
    v = gets.to_i

    t[0].increase_speed(v)
    puts "Поезд номер #{t[0].number} разогнался до скорости #{@speed} километров в час."
  end

  def stop
    puts 'Введите номер поезда:'
    t = select_train

    t[0].stop
    puts "Поезд #{t[0].number} остановился."
  end
end
