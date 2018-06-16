class Station
  include InstanceCounter
  include Validation

  attr_accessor :trains, :station_name
  validate :station_name, :presence
  validate :station_name, :type, String


  def self.storage_stations
    @@storage_stations
  end

  @@storage_stations = []

  def initialize(station_name)
    @station_name = station_name
    validate!
    @trains = []
    @trains_at_station_by_type = {}
    register_instance
    @@storage_stations << self
  end

  def list_of_trains(block)
    trains.each do |train|
      block.call(train)
    end
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end

  def trains_at_station_by_type(type = nil)
    if type
      @trains_at_station_by_type.count
    else
      @trains_at_station_by_type[type.to_sym] = trains.reduce(0) { |count, train| train.type == type.to_sym ? count + 1 : count }
    end
  end
end
