# frozen_string_literal: true

# routes
class Route
  attr_reader :station_list

  def initialize(first, last)
    @station_list = [first, last]
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end
end
