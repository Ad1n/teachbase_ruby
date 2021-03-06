puts "Введите поочередно день, месяц и год: "
# Поочередно получаем от пользователя данные о дне, месяце и номере года
day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

# С помощью функции вычисляем високосный ли год
def is_leap_year(year)
  if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    29
  else
    28
  end
end

# Заносим в массив количество дней в месяцах
# Для февраля значение количества дней вычисляется при помощи функции is_leap_year(year)
# Первый элемент равен нулю на случай ввода пользователем первого месяца, дабы не уйти в минус
# по индексам
days_in_month = [0, 31, is_leap_year(year), 31, 30, 31, 30, 31, 31, 30, 31, 30]

# Обрезаем массив до диапазоно целых месяцев, входящих в сумму. Затем сумируем их
full_months_days_total = days_in_month[0...month].sum
puts full_months_days_total + day
