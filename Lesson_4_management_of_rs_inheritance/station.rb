class Station

  include InstanceCounter
  include Validation

  def self.storage_stations
    @@storage_stations
  end

  attr_accessor :trains, :station_name

  @@storage_stations = []

  def initialize(station_name)
    @station_name = station_name
    validate!
    @trains = []
    @trains_at_station_by_type = {}
    register_instance
    @@storage_stations << self
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

  private

  def validate!
    raise 'Type station name please.' if station_name.empty?
    raise "Too mach symbols in station name: #{station_name.length}" if station_name.length > 25
    raise "Too small for station name: #{station_name.length}" if station_name.length < 2
    true
  end
end
