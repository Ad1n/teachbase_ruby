class Station

  attr_reader :trains, :station_name


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

  def trains_at_station_by_type
    passenger = trains.reduce(0) { |count, train| train.type == :passenger ? count + 1 : count }
    cargo = trains.select { |t| t.type == :cargo }.reduce(&:+)
    trains_at_station_by_type[:passenger] = passenger
    trains_at_station_by_type[:cargo] = cargo
    trains_at_station_by_type
  end

  private

  # Запрет на изменение состава поездов на станции , а также на изменение имени станции
  # В секции private так как не планируется наследников данного класса
  attr_writer :trains, :station_name

end
