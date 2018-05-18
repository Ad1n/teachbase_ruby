arr = [0, 1]
# Задаем значения индексов первых двух значений массива
first_elem = 0
second_elem = 1

loop do
  # Вычисляем значение следующего числа фибоначчи
  sum_elements = arr.fetch(first_elem) + arr.fetch(second_elem)
  # Останавливаем цикл если значение числа превышает 100. Если нет - заносим число в массив
  sum_elements < 100 ? arr.push(sum_elements) : break
  # Если цикл продолжен увеличиваем значение индексов массива для вычисления следующей суммы чисел в массиве
  first_elem += 1
  second_elem += 1
end

puts arr
