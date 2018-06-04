class Wagon

  include Manufacturer
  attr_accessor :wagon_number, :wagon_manufacturer

  def initialize
    p 'Enter wagon number: '
    @wagon_number = gets.chomp!.to_i
    create_manufacturer
  end

end
