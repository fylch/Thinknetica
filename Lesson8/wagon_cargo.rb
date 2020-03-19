# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :volume, :filled_volume, :type
  @@instances = 0

  def initialize(number, volume, type = 'грузовой')
    @number = number
    @volume = volume
    @filled_volume = 0
    @type = type
    validate!
    register_instances
  end

  def info
    "Вагон №#{@number}. Общий объём: #{@volume}, заполненный" \
    " объём: #{@filled_volume}, свободный объём: #{available_volume}."
  end

  def fill_the_volume(fill)
    @filled_volume += fill.to_i
  end

  def available_volume
    @available_volume = @volume.to_i - @filled_volume.to_i
  end
end
