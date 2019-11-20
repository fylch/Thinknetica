puts 'Tell me your name, please: '
name = gets.chomp

puts 'Tell me your height, please: '
height = gets.chomp.to_i

ideal = (height - 110) * 1.15

if ideal >= 0
  puts "Hello, #{name}. Your ideal weight is #{ideal}"
else
  puts "Helo, #{name}, your weight is optimal now"
end
