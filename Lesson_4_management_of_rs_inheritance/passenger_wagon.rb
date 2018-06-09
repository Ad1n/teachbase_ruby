class PassengerWagon < Wagon

  attr_reader :type_wagon, :total_seats
  attr_accessor :total_take_seats

  def initialize(wagon_number, total_seats_number)
    @wagon_number = wagon_number
    validate!
    @type_wagon = :passenger
    # Общее количество мест
    @total_seats = total_seats_number
    # Количество занятых мест
    @total_take_seats = 0
  end

  def total_free_seats
    total_seats - total_take_seats
  end

  def take_seat
    raise "There is no free seats in wagon № #{wagon_number}" if total_free_seats.zero?
    self.total_take_seats += 1
  end

end
