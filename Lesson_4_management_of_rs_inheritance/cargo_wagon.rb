class CargoWagon < Wagon

  attr_reader :type_wagon, :total_volume, :wagon_number
  attr_accessor :total_load_volume

  def initialize(wagon_number, total_wagon_volume)
    @wagon_number = wagon_number
    validate!
    @type_wagon = :cargo
    # Вместимость вагона
    @total_volume = total_wagon_volume
    # Занятый объем в вагоне
    @total_load_volume = 0
  end

  def total_free_volume
    total_volume - total_load_volume
  end

  def load_wagon(volume)
    self.total_load_volume += volume
    raise "There is no such free volume in wagon № #{wagon_number}" if total_free_volume < volume
  end
end
