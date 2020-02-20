# frozen_string_literal: true
require_relative 'company_name.rb'
require_relative 'counter.rb'
# trains
class Train
  include CompanyName
  include InstanceCounter

  attr_reader :speed, :wagons, :type, :current_station, :number, :route

  NUMBER_FORMAT = /^\w{3}-*\w{2}$/i

  @@trains = []

  def self.trains
    @@trains
  end

  def self.find(number)
    self.trains.select { |train| number == train.number}
  end

  def initialize(number, type, speed = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = speed
    validate!
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

  def to_s
    "#{self.type.capitalize} поезд номер #{self.number} находится на станции #{@current_station.name}, вагонов у поезда #{self.wagon_info.size}. Поезд движется со скоростью #{self.current_speed} км/ч."
  end

  def add_wagons(wagon)
    @wagons << wagon
    wagon.train=(self.number)
  end

  def delete_wagons(wagon)
    @wagons.delete(wagon)
    wagon.train=(nil)
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
    @route.stations.select { |station| station.trains.include?(self) }
  end

  def move_forward
    check_last_station
    if @current_station != route.last
      @current_station.delete_trains(self)
      @current_station = next_station
      @current_station.add_trains(self)
   end
  end

  def move_back
    check_first_station
    if @current_station != route.first
      @current_station.delete_trains(self)
      @current_station = previous_station
      @current_station.add_trains(self)
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

protected

  def validate!
    raise 'Номер не может быть пустым.' if @number.nil?
    raise "Формат номера неверный. Номер должен состоять из 5 цифр или букв, которые можно разделять дефисом после третьего знака, например '1a3-ds'." if @number !~ NUMBER_FORMAT 
  end

  def check_first_station
    raise 'Это первая станция в маршруте, поезд не может переместиться на предыдущую станцию ввиду отсутствия таковой.' if @current_station == route.first
  end

  def check_last_station
    raise 'Это последняя станция в маршруте, поезд не может переместиться на следующую станцию ввиду отсутствия таковой.' if @current_station == route.last
  end
end
