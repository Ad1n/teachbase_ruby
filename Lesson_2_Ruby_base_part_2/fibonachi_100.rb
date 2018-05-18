arr = [0, 1]

loop do
  # Вычисляем значение следующего числа фибоначчи
  total_elements = arr.fetch(-2) + arr.fetch(-1)
  # Останавливаем цикл если значение числа превышает 100. Если нет - заносим число в массив
  total_elements < 100 ? arr.push(total_elements) : break
end

puts arr
