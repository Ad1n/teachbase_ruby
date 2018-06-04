module Manufacturer
  attr_reader :manufacturer

  def create_manufacturer
    p 'Enter manufacturer: '
    @manufacturer = gets.chomp!
  end
end
