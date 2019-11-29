basket = { }
total = 0

puts 'Enter the name of the product. For break input stop.'
name = gets.chomp.to_s

while name != 'stop'
  puts 'Enter the price of the product: '
  price = gets.chomp.to_i

  puts 'Enter the numbers of the product: '
  quantity = gets.chomp.to_i

  basket[name] = {price: price, quantity: quantity}

 	puts 'Enter the name of the product. For break input stop.'
 	name = gets.chomp

end

puts 'Here are the basket contents:'
puts basket

basket.each_key() do |key|
  amount = basket[key][:price] * basket[key][:quantity]
  total += amount
  puts "#{key}: #{amount}"
end

puts "Total sum in basket: #{total}."
