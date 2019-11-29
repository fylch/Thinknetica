puts "Enter the day, please: "
day = gets.chomp.to_i

puts "Enter the month, plese: "
month = gets.chomp.to_i

puts "Enter the year, please: "
year = gets.chomp.to_i

hash = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

current_date = hash.values.first(hash.keys.index(month)).sum + day

if (year % 4 == 0 && year % 100 != 0 ) || year % 400 == 0
  print 'Today is the ' + (current_date + 1).to_s + 'th day of the year.'
else
 print 'Today is the ' + current_date.to_s + 'th day of the year.'
end
