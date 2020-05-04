# frozen_string_literal: true
require_relative 'module_validation.rb'

class CargoTrain < Train
  include Validation
  @@instances = 0
  validate :number, :presence
  validate :number, :format, /^\w{3}-*\w{2}$/i.freeze

  def initialize(number, type = 'грузовой', speed = 0)
    super
  end
end
