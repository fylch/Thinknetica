# frozen_string_literal: true

# stations
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end
end
