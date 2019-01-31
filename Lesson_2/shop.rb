materials = Hash.new

loop do 

puts "Введите название товара(-stop- для окончания): "
name = gets.chomp.downcase 

break if name == "stop"

puts "Цена за единцу товара: "
price = gets.to_f

puts "Введите количество товара: "
quantity = gets.to_i

materials[name] = {price: price, quantity: quantity}  
end

sum = 0

materials.each do |key, value| 
  materials_sum = value[:price] * value[:quantity]
  sum += materials_sum
 puts "#{key} в количестве: #{value[:quantity]}шт. по #{value[:price]}$ Итог: #{materials_sum}$"
end

 puts "Общая сумма покупок на #{sum}$"