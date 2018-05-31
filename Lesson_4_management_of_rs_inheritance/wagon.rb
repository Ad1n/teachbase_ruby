class Wagon

  attr_accessor :wagon_number

  def initialize
    p 'Enter wagon number: '
    @wagon_number = gets.chomp!.to_i
  end

end
