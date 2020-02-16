class Wagon
  include CompanyName
  include InstanceCounter

  attr_reader :number, :type
  attr_accessor :train

  NUMBER_FORMAT = /\w{5}/

  def initialize(number, type)
    @type = type
    @number = number
    register_instances
    validate!
  end

  def valid?
  	validate!
  	true
  rescue
  	false
  end

  def validate!
  	raise 'Номер не должен быть пустым.' if number.nil?
  	raise 'Номер должен содержать не более 5 символов.' if number.length > 5
  end
end
