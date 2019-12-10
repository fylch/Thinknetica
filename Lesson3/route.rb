# frozen_string_literal: true

# routes
class Route
  attr_accessor :station_list

  def initialize(first, last)
    @first = first
    @last = last
    @station_list = [first, last]
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end
end
