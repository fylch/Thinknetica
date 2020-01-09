class CargoWagon < Wagon

  def initialize(number, type = 'грузовой')
    @type = type
    @number = number
  end
end
