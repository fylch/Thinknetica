alphabet = ('a'..'z').to_a
numbers = (1..26).to_a

h = [alphabet, numbers] 

print h.transpose.to_h.select { |k, v| k =~ /[aeiou]/ }
