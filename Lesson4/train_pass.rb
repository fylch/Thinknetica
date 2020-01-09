class PassTrain < Train

  def initialize(number, type = 'пассажирский', speed = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = speed
  end
end
