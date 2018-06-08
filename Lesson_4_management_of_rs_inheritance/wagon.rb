class Wagon

  include Manufacturer
  include Validation
  attr_accessor :wagon_number, :wagon_manufacturer

  WAGON_NUMBER = /^[1-9]{1,2}$/

  def initialize(wagon_number, _)
    @wagon_number = wagon_number
    validate!
  end

  protected

  def validate!
    raise 'Wrong wagon number' if wagon_number.to_s !~ WAGON_NUMBER
    true
  end
end
