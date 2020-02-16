# frozen_string_literal: true

# stations
class Station
  include InstanceCounter
  attr_reader :trains, :name

  NAME_FORMAT = /[а-я]/i

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self.name
    register_instances
    validate!
  end

  def add_trains(train)
    @trains << train
  end

  def delete_trains(train)
    @trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Имя не может быть пустым.' if name.nil?
    raise 'Имя должно содержать русские буквы.' if name !~ NAME_FORMAT
  end
end
