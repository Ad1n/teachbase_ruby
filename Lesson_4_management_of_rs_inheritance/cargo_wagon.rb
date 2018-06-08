class CargoWagon < Wagon

  attr_reader :type_wagon, :total_volume
  attr_accessor :total_free_volume, :total_load_volume

  def initialize(wagon_number, total_wagon_volume)
    super
    @type_wagon = :cargo
    # Вместимость вагона
    @total_volume = total_wagon_volume
    # Занятый объем в вагоне
    @total_load_volume = 0
    # Свободный объем
    @total_free_volume = total_wagon_volume - total_load_volume
  end

  def load_wagon(volume)
    self.total_free_volume -= volume
    self.total_load_volume += volume
  end
end
