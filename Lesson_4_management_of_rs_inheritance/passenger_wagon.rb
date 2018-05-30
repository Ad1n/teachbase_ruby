class PassengerWagon < Wagon

  attr_reader :type_wagon

  def initialize
    super
    @type_wagon = :passenger
  end

end
