# frozen_string_literal: true

# trains
class Train
  attr_reader :speed, :vagons, :type, :current_station

  def initialize(number, type, vagons, speed = 0)
    @number = number
    @type = type
    @vagons = vagons
    @speed = speed
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

  def add_vagons
    return unless current_speed.zero?

    @vagons += 1
  end

  def delete_vagons
    return unless current_speed.zero?

    @vagons -= 1
  end

  def route=(route)
    @route = route
    @current_station = @route.station_list.first
    @current_station.add_trains(self)
  end

  def previous_station
    @route.station_list[@route.station_list.index(@current_station) - 1]
  end

  def next_station
    @route.station_list[@route.station_list.index(@current_station) + 1]
  end

  def current_station
    @route.station_list.each { |station| station.trains.include?(self) }
  end

  def move_forward
    @current_station.delete_trains(self)
    @current_station = next_station
    @current_station.add_trains(self)
  end

  def move_back
    @current_station.delete_trains(self)
    @current_station = previous_station
    @current_station.add_trains(self)
  end
end
