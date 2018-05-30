class CargoWagon < Wagon

  attr_reader :type_wagon

  def initialize
    super
    @type_wagon = :cargo
  end

end
