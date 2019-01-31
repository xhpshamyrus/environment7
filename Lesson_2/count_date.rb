puts "Введите день: "
day = gets.chomp.to_i

puts "Введите месяц: "
month = gets.chomp.to_i

puts "Введите год: "
year = gets.chomp.to_i

day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_year = year % 400 == 0 || year % 4 == 0 && year % 100 !=0
day_in_months[1] = 29 if leap_year
date_number = day_in_months.take(month - 1).sum + day

puts "Порядковый номер даты: #{date_number}"

=begin
another way via hash

day_in_months = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31,
6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31} 

leap_year = year % 400 == 0 || year % 4 == 0 && year % 100 !=0
date_scope = day_in_months.select{ |key| key < month }
day += 1 if leap_year
date_number = date_scope.values.sum + day

puts "Порядковый номер даты: #{date_number}"
=end
