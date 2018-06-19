class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_accessor :wagons
  attr_reader :route, :number, :speed

  validate :number, :presence

  def self.find(number)
    @@storage_trains[number.to_s]
  end

  @@storage_trains = {}

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    validate!
    register_instance
    @@storage_trains[self.number] = self
  end

  def list_of_wagons(block)
    wagons.each do |wagon|
      block.call(wagon)
    end
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
