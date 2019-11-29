basket = { }

puts 'Enter the name of the product: '
name = gets.chomp.to_s

while name != 'stop'
  puts 'Enter the price of the product: '
  price = gets.chomp.to_i

  puts 'Enter the numbers of the product: '
  quantity = gets.chomp.to_i

  basket[name] = {price: price, quantity: quantity}

 	puts 'Enter the name of the product: '
 	name = gets.chomp

end

puts 'Here are the basket contents:'
puts basket

basket.each do |name,allprice|
  puts "Product #{name}, total cost: #{allprice[:price] * allprice[:quantity]}."
end

total = basket.inject(0) do |price, quantity|
  price + quantity[1][:price] * quantity[1][:quantity]
end

puts "Total sum in basket: #{total}."
