puts "Поочередно введите значения коэфицентов a, b, c квадратного уравнения вида ax^2+bx+c=0 : "
a = Integer(gets.chomp)
b = Integer(gets.chomp)
c = Integer(gets.chomp)

D = b**2 - 4 * a * c 												 #Вычисляем дискриминант
case 																 # Проверяем возможные значения D	
	when b**2 - 4 * a * c > 0								         # Если D > 0, то выполняем данный блок кода 	
		puts "Дискриминант равен: " + String(D) + 
		     ". Квадратное уравнение имеет два корня. x1 = " +
		      String( (-b + Math.sqrt(D) ) / 2 * a) + 
			 " x2 = " + String( (-b - Math.sqrt(D) ) / 2 * a)

	when b**2 - 4 * a * c == 0										 # Если D == 0, то этот блок
		puts "Дискриминант равен: " + String(D) + 
		     ". Корни уравнения равны (х1 = х2) и имеют значение: " +
		      String(-b / 2 * a)

	when b**2 - 4 * a * c < 0										 # Если D < 0, то будет исполнен данный блок
		puts "Дискриминант равен: " + String(D) + ". Корней нет."
else
	puts "Коэфиценты введены не корректно."							 # else выполнится если не подойдет 
																	 # ни одно условие с D.
end
