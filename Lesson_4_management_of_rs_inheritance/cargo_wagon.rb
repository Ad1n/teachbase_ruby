class CargoWagon < Wagon

  attr_reader :type_wagon

  def initialize(wagon_number)
    super
    @type_wagon = :cargo
  end

end
