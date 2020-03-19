# frozen_string_literal: true

require_relative 'counter.rb'
# routes
class Route
  include InstanceCounter
  attr_reader :stations, :name_route, :first, :last

  NAME_ROUTE_FORMAT = /[0-9]|[а-я]/i.freeze

  def initialize(name_route, first, last)
    @first = first
    @last = last
    @name_route = name_route
    validate!
    @stations = [first, last]
    register_instances
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Имя не может быть пустым.' if name_route.nil?
    if name_route !~ NAME_ROUTE_FORMAT
      raise 'Имя должно содержать русские буквы или цифры.'
    end
    raise 'Имя не может быть пустым.' if first.nil?
    raise 'Имя не может быть пустым.' if last.nil?
  end
end
