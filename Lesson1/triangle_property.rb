puts 'Tell me the length of side a: '
a = gets.chomp.to_f

puts 'Tell me the length of side b: '
b = gets.chomp.to_f

puts 'Tell me the length of side c: '
c = gets.chomp.to_f

h = [a, b, c].sort

if (a == b) && (b == c)
  puts 'Triangle is equal'
elsif h[2]**2 == h[1]**2 + h[0]**2
  puts 'Triangle is right-angled'
elsif (a == b) || (b == c) || (a == c)
  puts 'Triangle is isoscales'
else
  puts 'It is just a triangle'
end
