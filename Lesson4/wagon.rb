class Wagon

  attr_reader :number, :type
  attr_accessor :train

  def initialize(number, type)
    @type = type
    @number = number
  end

  def info
    puts "Вагон номер #{self.number} прицеплен к поезду #{self.train}."
  end
end
