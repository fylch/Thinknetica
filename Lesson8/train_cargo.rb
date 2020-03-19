# frozen_string_literal: true

class CargoTrain < Train
  @@instances = 0

  def initialize(number, type = 'грузовой', speed = 0)
    super
  end
end
