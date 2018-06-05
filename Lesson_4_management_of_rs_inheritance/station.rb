class Station

  include InstanceCounter

  class << self
    attr_accessor :storage_stations
  end

  attr_accessor :trains, :station_name, :trains_at_station_by_type

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @trains_at_station_by_type = {}
    register_instance
    self.class.storage_stations ||= []
    self.class.storage_stations << self
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
