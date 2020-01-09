# frozen_string_literal: true

# routes
class Route
  attr_reader :stations, :name_route, :first, :last

  def initialize(name_route, first, last)
    @first = first
    @last = last
    @stations = [first, last]
    @name_route = name_route
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
