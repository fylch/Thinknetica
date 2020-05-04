class TestClass; end

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'

# исключения
begin
  action ||= 0
  case action
  when 0
    CargoTrain.new('123')
  when 1
    station = Station.new(123)
  when 2
    station = Station.new('')
  end
rescue RuntimeError => e
  action += 1
  puts e.message
  retry
end

# attr_accessor_with_history
station1 = Station.new('Финляндский вокзал')
station2 = Station.new('Зеленогорск')
station3 = Station.new('Репино')
route = Route.new('ФинЗел', station1, station2)
route.stations << station3
route.stations = 'Комарово'
route.stations = 'Белоостров'
puts("Accessor history: #{route.stations_history}")

# strong_attr_accessor
route.first = Station.new('Комарово')
puts route.first.name
route.first = PassTrain.new('12453')
puts route.first