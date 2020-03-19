# frozen_string_literal: true

class Wagon
  include CompanyName
  include InstanceCounter

  attr_reader :number, :type
  attr_accessor :train

  NUMBER_FORMAT = /\w{5}/.freeze

  def initialize(number, type)
    @type = type
    @number = number
    validate!
    register_instances
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Номер не должен быть пустым.' if number.nil?
    raise 'Номер должен содержать не более 5 символов.' if number.length > 5
  end
end
