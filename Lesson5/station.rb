# frozen_string_literal: true

# stations
class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self.name
    register_instances
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end
end
