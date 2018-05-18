# Создаем хэш для занесения товаров
shop = {}
# Заносим в хэш товары до команды "стоп"
loop do
  puts "Введите наименование товара. Для остановки ввода введите 'стоп' :"
  name = gets.chomp
  break if name == 'стоп'
  puts "Введите цену единицы товара :"
  price_for_one = gets.chomp.to_f
  puts "Введите количество товара :"
  count = gets.chomp.to_i

  shop[name] = { price: price_for_one, count: count }
end
# Создаем переменную для общей суммы по покупке
total = 0
# Выводим данные о каждом товаре
shop.each do |k, v|
  sum = v[:price] * v[:count]
  puts "Наименование товара: #{k}.  Итого за товар: #{sum} "
  total += sum
end
# Выводим общую сумму
puts "Итого: #{total}"
