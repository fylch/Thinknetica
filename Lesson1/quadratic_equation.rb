puts 'Puts a, please: '
a = gets.chomp.to_f

puts 'Puts b, please: '
b = gets.chomp.to_f

puts 'Puts c, please: '
c = gets.chomp.to_f

D = (b**2 - (4 * a * c)).to_f
R = Math.sqrt(D) if D >= 0
root1 = (- b + R)/(2 * a) if D >= 0
root2 = (- b - R)/(2 * a) if D >= 0

if D < 0
  puts "D = #{D}, there is no roots"
elsif D == 0
  puts "D = #{D}, root is #{root1}"
elsif D > 0
  puts "D = #{D}, first root is #{root1}, second root is #{root2}"
end
