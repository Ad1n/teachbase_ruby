# Создаем и заполняем массив буквами русского алфавита
letters = ('а'...'я').to_a
# Создаем хэш для алфавита и массив гласных букв
alphabet = {}
vowels = ['а', 'о', 'и', 'е', 'э', 'ы', 'у', 'ю', 'я']
# Заполняем хэш буквами алфавита и их соответствующим порядковым номером
letters.each do |i|
  alphabet[i] = letters.find_index(i) + 1
end
# Перебираем хэш и выводим только гласные буквы
alphabet.each_key do |l|
  if vowels.include?(l)
    puts "#{l} - #{alphabet.fetch(l)}"
  end
end
