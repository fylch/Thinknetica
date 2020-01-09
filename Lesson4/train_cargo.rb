class CargoTrain < Train

  def initialize(number, type = 'грузовой', speed = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = speed
  end
end
