class PassengerTrain < Train
  attr_reader :type

  validate :number, :presence
  validate :number, :format, /^([1-9]{3}||[a-z]{3})\-?([1-9]{2}||[a-z]{2})$/i

  def initialize(number)
    super
    @type = :passenger
  end
end
