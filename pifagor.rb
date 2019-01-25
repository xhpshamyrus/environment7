sides = []
puts "Введите сторону A"
sides << gets.to_f

puts "Введите сторону B"
sides << gets.to_f

puts "Введите сторону C"
sides << gets.to_f

cathetus_a, cathetus_b, hypotenuse = sides.sort!
rectangular = cathetus_a**2 + cathetus_b**2 == hypotenuse**2 
equalterial = cathetus_a == cathetus_b && cathetus_a == hypotenuse

if rectangular && cathetus_a == cathetus_b
  puts "Треугольник прямоугольный и равнобедренный"
elsif rectangular
  puts "Треугольник прямоугольный"
elsif equalterial
  puts "Треугольник равносторонний"
else
  puts "Треугольник разносторонний"
end
