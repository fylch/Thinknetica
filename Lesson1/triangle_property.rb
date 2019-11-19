puts "Tell me the length of side a: "
a = gets.chomp.to_f

puts "Tell me the length of side b: "
b = gets.chomp.to_f

puts "Tell me the length of side c: "
c = gets.chomp.to_f

if (a == b) && (a == c)
  puts "Triangle is equal"
elsif (a > b) && (a > c) && (a ** 2) == (b ** 2 + c ** 2)
  puts "Triangle is right-angled"
elsif (b > a) && (b > c) && (b ** 2) == (a ** 2 + c ** 2)
  puts "Triangle is right-angled"
elsif (c > a) && (c > b) && (c ** 2) == (a ** 2 + b ** 2)
  puts "Triangle is right-angled"
elsif (a == b) || (b == c) || (a == c)
  puts "Triangle is isoscales"
else
  puts "It is just a triangle"
end
