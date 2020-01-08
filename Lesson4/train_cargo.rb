class CargoTrain < Train
  def add_wagons(wagon)
    super if wagon.class == CargoWagon
  end
end
