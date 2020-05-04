# frozen_string_literal: true

require_relative 'module_company_name.rb'
require_relative 'module_counter.rb'
require_relative 'module_accessors.rb'
require_relative 'module_validation.rb'
# trains
class Train
  include CompanyName
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :wagons
  attr_reader :speed, :wagons, :type, :current_station, :number, :route

  validate :number, :presence
  validate :number, :format, /^\w{3}-*\w{2}$/i.freeze

  @@trains = []

  def self.trains
    @@trains
  end

  def self.find(number)
    trains.select { |train| number == train.number }
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

  def wagon_info
    @wagons.each { |wagon| yield(wagon) } if block_given?
  end

  def add_wagons(wagon)
    @wagons << wagon
    wagon.train = number
  end

  def delete_wagons(wagon)
    @wagons.delete(wagon)
    wagon.train = nil
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
    @current_station.delete_trains(self)
    @current_station = next_station
    @current_station.add_trains(self)
  end

  def move_back
    check_first_station
    @current_station.delete_trains(self)
    @current_station = previous_station
    @current_station.add_trains(self)
  end

  protected

  def check_first_station
    raise 'Это первая станция в маршруте, поезд не может переместиться на ' \
    'предыдущую станцию ввиду отсутствия ' \
    'таковой.' while @current_station == route.first
  end

  def check_last_station
    raise 'Это последняя станция в маршруте, поезд не может переместиться на ' \
    'следующую станцию ввиду отсутствия ' \
    'таковой.' while @current_station == route.last
  end
end
