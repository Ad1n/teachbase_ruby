class Wagon

  attr_reader :wagon_number

  def initialize
    @wagon_number = 227
  end

  def change_wagon_number(wagon_number)
    @wagon_number = wagon_number
  end

  protected

  # Закрыт доступ к изменению пользователем номера вагона
  # В секции protected, чтобы сеттер был доступен в наследниках
  attr_writer :wagon_number
end
