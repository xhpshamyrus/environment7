vowels = %w(a e i o u y)
alphabet = ('a'..'z')
vowels_hash = {}

alphabet.each_with_index do |value, index|
  vowels_hash[value] = index + 1 if vowels.include?(value)
end 
puts vowels_hash
