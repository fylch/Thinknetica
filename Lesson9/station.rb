# frozen_string_literal: true

# stations

require_relative 'module_counter.rb'
require_relative 'module_accessors.rb'
require_relative 'module_validation.rb'

class Station
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor_with_history :trains
  attr_reader :name

  validate :name, :presence
  validate :name, :format, /^[а-я]/i.freeze
  validate :name, :type, String

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self.name
    register_instances
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end

  def info
    @trains.each { |train| yield(train) } if block_given?
  end
end
