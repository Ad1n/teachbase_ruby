class Station

  attr_accessor :trains, :station_name, :trains_at_station_by_type

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @trains_at_station_by_type = {}
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end

  def trains_at_station_by_type(type = nil)
    if type.nil?
      @trains_at_station_by_type.count
    else
      @trains_at_station_by_type[type.to_sym] = trains.reduce(0) { |count, train| train.type == type.to_sym ? count + 1 : count }
    end
  end
end
