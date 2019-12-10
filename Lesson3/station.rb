# frozen_string_literal: true

# stations
class Station
  attr_accessor :trains, :station

  def initialize(station)
    @station = station
    @trains = []
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end

  def trains_type(type)
    @trains.select { |train| train if train.type == type }
  end
end
