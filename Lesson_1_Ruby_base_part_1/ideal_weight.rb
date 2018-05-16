print "Представьтесь пожалуйста. Введите ваше имя: "

# вводим имя пользователя
name = gets.chomp.capitalize!

# вводим значение роста
print "И ваш рост: "
growth = gets.chomp.to_i

# вычисляем идеальный вес
ideal_weight = growth - 110

# выводим результат
if ideal_weight > 0
  puts "Уважаемый #{name}, ваш идеальный вес равен: #{ideal_weight}"
else
  "Ваш вес уже оптимальный!"
end
