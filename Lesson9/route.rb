# frozen_string_literal: true

require_relative 'module_counter.rb'
require_relative 'module_accessors'
require_relative 'module_validation'
# routes
class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor_with_history :stations
  strong_attr_accessor :first, Station
  attr_reader :name_route, :first, :last

  validate :name_route, :presence
  validate :name_route, :format, /[0-9]|[а-я]/i.freeze
  validate :first, :presence
  validate :first, :type, Station
  validate :last, :presence
  validate :last, :type, Station

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
end
