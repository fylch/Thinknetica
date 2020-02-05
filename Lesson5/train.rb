require_relative 'counter.rb'
require_relative 'company_name.rb'
# frozen_string_literal: true

# trains
class Train
  include CompanyName
  include InstanceCounter

  attr_reader :speed, :wagons, :type, :current_station, :number, :route

  @@trains = []

  def self.trains
    @@trains
  end

  def self.find(number)
    self.trains.select { |train| number == train.number}
  end

  def initialize(number, type, speed = 0)
    @number = number.to_i
    @type = type
    @wagons = []
    @speed = speed
    @@trains << self
    register_instances
  end

  def current_speed
    @speed = speed
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagons(wagon)
    if current_speed.zero?
      if wagon.type != self.type
        puts 'Вагон и поезд должны быть одного типа!'
      else
        @wagons << wagon
        puts "#{wagon.type.capitalize} вагон номер #{wagon.number} прицеплен к поезду номер #{self.number}."
        wagon.train=(self.number)
      end
    else
      puts 'Нужно остановить поезд, прежде чем прицеплять или отцеплять вагоны!'
    end
  end

  def delete_wagons(wagon)
    if current_speed.zero?
      @wagons.delete(wagon)
      puts "Вагон #{wagon.type} отцеплен!"
    else
      puts 'Нужно остановить поезд, прежде чем прицеплять или отцеплять вагоны!'
    end
  end

  def info
    puts "#{self.type.capitalize} поезд номер #{self.number} находится на станции #{@current_station.name}, вагонов у поезда #{self.wagon_info.size}. Поезд движется со скоростью #{self.current_speed} км/ч."
  end

  def wagon_info
    @wagons
  end

  def route=(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.add_trains(self)
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1]
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1]
  end

  def current_station
    @route.stations.each { |station| station.trains.include?(self) }
  end

  def move_forward
    if @current_station == route.last
      puts 'Это последняя станция в маршруте, поезд не может переместиться на следующую станцию ввиду отсутствия таковой.'
    else
      @current_station.delete_trains(self)
      @current_station = next_station
      @current_station.add_trains(self)
    end
  end

  def move_back
    if @current_station == route.first
      puts 'Это первая станция в маршруте, поезд не может переместиться на предыдушую станцию ввиду отсутствия таковой.'
    else
      @current_station.delete_trains(self)
      @current_station = previous_station
      @current_station.add_trains(self)
    end
  end
end
