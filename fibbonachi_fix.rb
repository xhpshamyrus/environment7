fibonacci_array = [0, 1]
next_item = 1

while next_item < 100 do
  fibonacci_array << next_item
  next_item = fibonacci_array[-1] + fibonacci_array[-2]
end
