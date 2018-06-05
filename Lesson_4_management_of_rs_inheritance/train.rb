class Train

  include Manufacturer
  include InstanceCounter

  attr_accessor :speed, :wagons, :train_manufacturer
  attr_reader :route, :number, :speed

  class << self
    attr_accessor :storage_trains

    def find(number)
      storage_trains.select { |hash| hash[number.to_s] }
    end
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    register_instance
    self.class.storage_trains ||= {}
    self.class.storage_trains[self.number] = self
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

  def move_next_station
    next_station.train_arrival(self)
    current_station.train_departure(self)
  end

  def move_back_station
    back_station.train_arrival(self)
    next_station.train_departure(self)
  end

  def attach_wagon(wagon)
    wagons << wagon
  end

  def detach_wagon(wagon)
    wagons.delete(wagon)
  end

  def stop
    self.speed = 0
  end

  def route=(route)
    @route = route
    self.route.starting_station.trains << self
  end

end
