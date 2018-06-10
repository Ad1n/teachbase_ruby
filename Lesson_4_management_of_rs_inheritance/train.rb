class Train

  include Manufacturer
  include InstanceCounter
  include Validation

  TRAIN_NUMBER = /^([1-9]{3}||[a-z]{3})\-?([1-9]{2}||[a-z]{2})$/i

  attr_accessor :wagons
  attr_reader :route, :number, :speed

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

  protected

  def validate!
    raise "Wrong number #{number}" if number !~ TRAIN_NUMBER
    raise 'Number is empty!' if number.empty?
    raise "Wrong parameter of speed: #{speed}" if speed.nil?
    raise "Speed can't be negative: #{speed}" if speed < 0
    raise "OMG! To fast to furious: #{speed}. Max speed 120." if speed > 120
    true
  end

end
