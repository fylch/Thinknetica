class Wagon
  include CompanyName
  include InstanceCounter

  attr_reader :number, :type
  attr_accessor :train

  def initialize(number, type)
    @type = type
    @number = number
    register_instances
  end
end
