# frozen_string_literal: true
require_relative 'module_counter.rb'
require_relative 'module_accessors'
require_relative 'module_validation'
require_relative 'wagon.rb'

class PassWagon < Wagon
  include Validation

  attr_reader :seats, :taken_seats, :all_seats, :type
  @@instances = 0

  validate :number, :presence
  validate :number, :format, /\w{5}/.freeze

  def initialize(number, all_seats, type = 'пассажирский')
    @number = number
    @all_seats = all_seats
    @taken_seats = 0
    @type = type
    validate!
    register_instances
  end

  def info
    "Вагон №#{@number}. Общее количество мест: #{@all_seats}," \
    " занято мест #{@taken_seats}, свободно мест #{available_seats}."
  end

  def take_a_seat
    check_seat
    return if available_seats < 1

    @taken_seats += 1 if @available_seats.to_i >= 1 
  end

  def available_seats
    @available_seats = @all_seats.to_i - @taken_seats.to_i
  end

  protected

  def check_seat
   raise "В вагоне недостаточно места! Занято: #{taken_seats}, свободно: #{available_seats}." if available_seats < 1
  end
end
