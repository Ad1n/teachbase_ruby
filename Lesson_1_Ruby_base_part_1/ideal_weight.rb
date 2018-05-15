print "Представьтесь пожалуйста. Введите ваше имя: "
name = gets.chomp.capitalize!							#вводим имя пользователя

print "И ваш рост: "
growth = Integer(gets.chomp)							#вводим значение роста

ideal_weight = growth - 110 							#вычисляем идеальный вес

puts ideal_weight > 0 ? "Уважаемый #{name}, ваш идеальный вес равен: #{ideal_weight}" :
						"Ваш вес уже оптимальный!"

							#используя тернарный оператор if выводим результат

