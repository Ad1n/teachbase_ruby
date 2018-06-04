class Route

  include InstanceCounter

  attr_accessor :stations
  attr_reader :starting_station, :end_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stations = [starting_station, end_station]
    register_instance
  end

  def add_route_station(station, pos)
    stations.insert(pos, station)
  end

  def del_route_station(station)
    stations.delete(station)
  end

  def list_of_stations
    stations.each_with_index do |k, i|
      "#{i}  #{k.station_name}"
    end
  end

end
