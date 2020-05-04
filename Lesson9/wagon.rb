# frozen_string_literal: true

class Wagon
  include CompanyName
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :number, :type
  attr_accessor :train

  def initialize(number, type)
    @type = type
    @number = number
    validate!
    register_instances
  end
end
