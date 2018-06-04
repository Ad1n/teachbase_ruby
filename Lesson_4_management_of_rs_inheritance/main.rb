# Точка входа в приложение
require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'rzd'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'

p 'Welcome to RailRoad Management v2.0'

@rzd = Rzd.new
@rzd.start

p 'See u!'

