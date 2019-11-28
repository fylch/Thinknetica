basket = { }
basket1 = { }

name = ' '
price = 0
quantity = 0
total = 0
cost = 'cost'
count = 0

puts 'Enter the name of the product: '
name = gets.chomp.to_s

while name != 'stop'
  puts 'Enter the price of the product: '
  price = gets.chomp.to_i

  puts 'Enter the numbers of the product: '
  quantity = gets.chomp.to_i

  total = [price, quantity].inject { |x, y| x * y }

  basket[name] = {price => quantity, cost => total}
  basket1[name] = total

 	puts 'Enter the name of the product: '
 	name = gets.chomp

end

puts 'Here are the basket contents:'
basket.each do |key,value|
  puts "Product #{key}. Price, number, total cost #{value}."
end

puts 'Total sum in basket is ' + basket1.values.sum.to_s
