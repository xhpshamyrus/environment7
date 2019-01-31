cart = {}

loop do
  puts "Введите название товара(-stop- для окончания): "
  name = gets.chomp.downcase

  break if name == "stop"

  puts "Цена за единцу товара: "
  price = gets.to_f

  puts "Введите количество товара: "
  quantity = gets.to_i

  cart[name] = { price: price, quantity: quantity }
end

sum = 0
cart.each do |product_name, product_info|
  cart_sum = product_info[:price] * product_info[:quantity]
  sum += cart_sum
  puts "#{product_name} в количестве: #{product_info[:quantity]}шт. по #{product_info[:price]}$ Итог: #{cart_sum}$"
end

puts "Общая сумма покупок на #{sum}$"
