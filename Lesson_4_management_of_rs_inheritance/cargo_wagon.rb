class CargoWagon < Wagon
  attr_reader :type_wagon, :total_volume, :wagon_number
  attr_accessor :total_load_volume

  validate :wagon_number, :presence
  validate :wagon_number, :format, /^[1-9]{1,2}$/

  def initialize(wagon_number, total_wagon_volume)
    @wagon_number = wagon_number
    @total_volume = total_wagon_volume
    validate!
    @type_wagon = :cargo
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
