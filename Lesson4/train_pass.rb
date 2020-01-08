class PassTrain < Train
  def add_wagons(wagon)
    super if wagon.class == PassWagon
  end
end
