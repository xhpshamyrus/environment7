puts "Введите коэффициент A"
a = gets.to_f

puts "Введите коэффициент B"
b = gets.to_f

puts "Введите коэффициент C"
c = gets.to_f
d = b**2 - (4 * a * c)

if d < 0 
  puts "Корней нет D = #{d}"
elsif d == 0
  x = -b / (2.0 * a)
  puts "D = 0, Один корень X = #{x}"
else 
  root = Math.sqrt(d) 
  x1 = (-b + root) / (2.0 * a)
  x2 = (-b - root) / (2.0 * a)
  puts "D = #{d}, имеем два корня: X1 = #{x1}, X2 = #{x2}"
end
