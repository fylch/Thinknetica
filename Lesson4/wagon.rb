class Wagon

  attr_reader :number, :type
  attr_accessor :train

  def initialize(number, type)
    @type = type
    @number = number
  end
end
