puts "Поочередно введите значения каждой из сторон треугольника: "
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

triangle = [a, b, c]
puts "Треугольник равнобедренный" if a == b || a == c || b == c	
puts "Треугольник равносторонний" if a == b && a == c	

#Находим самую длинную из сторон треугольника, удаляем ее значение из массива и 
#возводим значение предполагаемой гипотенузы в квадрат.																				
gipotenuza = triangle.delete(triangle.max)**2	

#Присваиваем переменной 
summa_kvadratov_katetov = triangle.collect! {|i| i**2}.sum

#Проверяем является ли треугольник прямоугольным по теореме пифагора												
puts gipotenuza == summa_kvadratov_katetov ? "Треугольник прямоугольный" : "Треугольник не прямоугольный"


=begin
Блок с IF если вдруг заинтересует кого
if a > b
	if a > c
		puts "a max"
	else
		puts "c max"
	end
elsif b > c
	puts "b max"
else 
	puts "c max"
end
=end


