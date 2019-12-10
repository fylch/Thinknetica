# frozen_string_literal: true

# trains
class Train
  attr_accessor :speed, :vagons, :route, :type
  attr_reader

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

  def current_station
    @route.station_list
  end
end
