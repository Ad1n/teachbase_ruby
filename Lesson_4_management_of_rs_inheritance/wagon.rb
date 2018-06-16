class Wagon
  include Manufacturer
  include Validation

  attr_accessor :wagon_number, :wagon_manufacturer
end
