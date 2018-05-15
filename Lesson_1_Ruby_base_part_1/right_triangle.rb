puts "Поочередно введите значения каждой из сторон треугольника: "
a = Integer(gets.chomp)
b = Integer(gets.chomp)
c = Integer(gets.chomp)

triangle = [a, b, c]
puts "Треугольник равнобедренный" if a == b || a == c || b == c	
puts "Треугольник равносторонний" if a == b && a == c											
gipotenuza = triangle.max ** 2														#Вычисляем гипотенузы перед удалением её из массива
triangle.delete(triangle.max)														#Удаляем максимальный элемент массива
puts gipotenuza == triangle.collect! {|i| i**2}.sum ? "Треугольник прямоугольный"   #Проверяем является ли треугольник прямоугольным по теореме пифагора
												: "Треугольник не прямоугольный"





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


