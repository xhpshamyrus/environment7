puts "Укажите Ваше имя?"
name = gets.chomp.capitalize

puts "Укажите Ваш рост?"
growth = gets.to_i

weight = growth - 110
if weight > 0
  puts "Ваше имя: #{name}, Ваш идеальный вас: #{weight}"
elsif weight < 0
  puts "У Вас уже идеальный вес!!!"
end