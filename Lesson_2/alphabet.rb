volves = ["a", "e", "i", "o", "u", "y"]

alphabet = ('a'..'z').to_a

array = {}

alphabet.each do |value|
if volves.include?(value)
  array[value] = alphabet.index(value) + 1
end
end

puts array
