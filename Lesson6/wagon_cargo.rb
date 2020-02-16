class CargoWagon < Wagon
  @@instances = 0

  def initialize(number, type = 'грузовой')
    super
  end
end
