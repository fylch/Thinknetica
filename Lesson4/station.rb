# frozen_string_literal: true

# stations
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def show_trains
    trains.each do |train|
      puts "Станция #{self.name}. Поезда на станции:"
      puts "Пассажирский поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'пассажирский'
      puts "Грузовой поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'грузовой'
    end
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end
end
