class Station

  attr_accessor :station_name
  attr_reader :trains


  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def train_arrival(train)
    if trains.include?(train)
      "Train is already at station #{station_name}"
    else
      trains << train
    end
  end

  def train_departure(train)
    if trains.include?(train)
      trains.delete(train)
    else
      "There is no trains with number #{train.number} at the station #{station_name}."
    end
  end

  def trains_at_station_by_type
    passenger = 0
    freight = 0

    trains.each { |t| passenger += 1 if t.type == 'passenger' }
    trains.each { |t| freight += 1 if t.type == 'freight' }

    "Passenger trains at station #{station_name}: #{passenger}. Freight trains at station #{station_name}: #{freight}"
  end
end

class Train

  attr_accessor :speed, :number_of_wagons
  attr_reader :route, :number, :type


  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def current_station
    cs = route.stations.detect { |s| s.trains.include?(self) }
    if cs.nil?
      puts 'Train has no route!'
    else
      cs
    end
  end

  def next_station
    current_index = route.stations.find_index(current_station)
    if route.stations[current_index] == route.end_station
      puts "You are on the final station #{route.stations.last.station_name}"
    else
      route.stations[current_index + 1]
    end
  end

  def back_station
    current_index = route.stations.find_index(current_station)
    if current_index.zero?
      puts "You are on the start station #{route.stations.first.station_name}"
    else
      route.stations[current_index - 1]
    end
  end

  def move_next_station
    if current_station.equal?(route.end_station)
      puts "It is the final destination #{current_station.station_name}"
    else
      next_station.train_arrival(self)
      current_station.train_departure(self)
    end
  end

  def move_back_station
    if current_station.equal?(route.starting_station)
      puts "It is the start station #{current_station.station_name}"
    else
      back_station.train_arrival(self)
      next_station.train_departure(self)
    end
  end

  def route=(route)
    @route = route
    self.route.starting_station.trains << self
  end

  def stop
    self.speed = 0
  end

  def attach_wagon
    if speed.zero?
      self.number_of_wagons += 1
    else
      'Sorry you move to fast for this action!'
    end
  end

  def detach_wagon
    if @speed.zero?
      self.number_of_wagons -= 1
    else
      'Sorry you move to fast for this action!'
    end
  end
end

class Route

  attr_reader :stations, :starting_station, :end_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stations = []
    stations << starting_station
    stations << end_station
  end

  def add_route_station(station)
    if stations.include?(station)
      "Station #{station.station_name} has already on the route."
    else
      puts list_of_stations
      print 'Print position number to extend stations list: '
      pos = gets.chomp!.to_i
      stations.insert(pos, station)
    end
  end

  def del_route_station(station)
    if stations.include?(station)
      stations.delete(station)
    else
      "There is no station #{station.station_name} on this route."
    end
  end

  def list_of_stations
    stations.each_with_index do |k, i|
      puts "#{i}  #{k.station_name}"
    end
  end
end
