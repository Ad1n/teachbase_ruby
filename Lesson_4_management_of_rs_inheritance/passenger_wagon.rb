class PassengerWagon < Wagon

  attr_reader :type_wagon, :total_seats
  attr_accessor :total_free_seats, :total_take_seats

  def initialize(wagon_number, total_seats_number)
    super
    @type_wagon = :passenger
    # Общее количество мест
    @total_seats = total_seats_number
    # Количество занятых мест
    @total_take_seats = 0
    # Количество свободных мест
    @total_free_seats = total_seats_number - total_take_seats
  end

  def take_seat
    self.total_free_seats -= 1
    self.total_take_seats += 1
  end

end
