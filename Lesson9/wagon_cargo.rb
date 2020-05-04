# frozen_string_literal: true

require_relative 'module_counter.rb'
require_relative 'module_accessors'
require_relative 'module_validation'
require_relative 'wagon.rb'

class CargoWagon < Wagon
  include Validation

  attr_reader :volume, :filled_volume, :type
  @@instances = 0

  validate :number, :presence
  validate :number, :format, /\w{5}/.freeze

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
    check_volume(fill)
    return if fill > @volume

    @filled_volume += fill.to_i if available_volume >= fill
  end

  def available_volume
    @available_volume = @volume.to_i - @filled_volume.to_i
  end

  protected

  def check_volume(fill)
   raise "В вагоне недостаточно места! Занято: #{filled_volume}, свободно: #{available_volume}." if available_volume < fill
  end
end
