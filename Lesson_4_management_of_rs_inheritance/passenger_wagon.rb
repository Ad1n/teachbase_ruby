class PassengerWagon < Wagon

  attr_reader :type_wagon

  def initialize(wagon_number)
    super
    @type_wagon = :passenger
  end

end
