class PassWagon < Wagon
  attr_reader :seats, :taken_seats, :all_seats, :type
  @@instances = 0

  def initialize(number, type = 'пассажирский', all_seats)
    @number = number
    @all_seats = all_seats
    @taken_seats = 0
    @type = type
    validate!
    register_instances
  end

  def info
    puts "  Вагон номер #{@number}. Общее количество мест: #{@all_seats}, занято мест #{@taken_seats}, свободно мест #{available_seats}."
  end

  def have_a_seat
  	@taken_seats += 1 if @available_seats.to_i <= @all_seats.to_i
  end

  def available_seats
    @available_seats = @all_seats.to_i - @taken_seats.to_i
  end
end
