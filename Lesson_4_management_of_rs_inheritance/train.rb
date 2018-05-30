class Train

  attr_reader :route, :number, :speed, :wagons

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 60
  end

  def current_station
    route.stations.detect { |s| s.trains.include?(self) }
  end

  def next_station
    current_index = route.stations.find_index(current_station)
    route.stations[current_index + 1]
  end

  def back_station
    current_index = route.stations.find_index(current_station)
    route.stations[current_index - 1]
  end

  def attach_wagon(wagon)
    wagons << wagon
  end

  def detach_wagon(wagon)
    wagons.delete(wagon)
  end

  # Доступ оставлен. Стоп-кран
  def stop
    self.speed = 0
  end

  def add_route(route)
    @route = route
    self.route.starting_station.trains << self
  end

  protected

  # Доступ к изменению состава закрыт для пользователя
  # Доступ к сеттерам скорости и маршрута тоже закрыт
  # В секции protected, чтобы методы и сеттеры были доступны в наследниках

  attr_writer :speed, :route, :wagons

  # Пользователь не должен иметь доступ к управлению поездом
  # Доступ к методам реализован через send :, но методы train_arrival и train_departure
  # закрыты для изменения пользователем в классе Station доступны пользователю
  def move_next_station
    next_station.train_arrival(self)
    current_station.train_departure(self)
  end

  def move_back_station
    back_station.train_arrival(self)
    next_station.train_departure(self)
  end

end
