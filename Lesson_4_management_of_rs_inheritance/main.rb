require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'


all_stations = []
all_trains = []
all_routes = []

p 'Welcome to RailRoad Management v2.0'

begin
  p 'Choose action: '
  p "Type '1' if u want to create station"
  p "Type '12' if u want to see all trains in some station" if all_stations.count != 0
  p "Type '2' if u want to create train"
  p "Type '9' if u want to move next station" if all_routes.count != 0 && all_trains.count != 0
  p "Type '10' if u want to move back station" if all_routes.count != 0 && all_trains.count != 0
  p "Type '7' if u want to attach wagon to train" if all_trains.count != 0
  p "Type '8' if u want to detach wagon from train" if all_trains.count != 0
  p "Type '3' if u want to create route" if all_stations.count >= 2
  p "Type '4' if u want to add station to the route" if all_routes.count != 0
  p "Type '11' if u want to see list of all stations in some route" if all_routes.count != 0
  p "Type '5' if u want to delete station from the route" if all_routes.count != 0
  p "Type '6' if u want to attach route to the train" if all_routes.count != 0 && all_trains.count != 0
  p "Type 'exit' to exit program"
  name = gets.chomp!
  case
  when name == '1'
    print 'Type name of the station: '
    station_name = gets.chomp!
    if station_name != ''
      all_stations << Station.new(station_name)
      p 'Station succesfully created'
    else
      p 'Print station name again !'
    end

  when name == '2'
    print 'Type number of the train: '
    number_of_train = gets.chomp!
    print 'Choose type of train between "passenger" and "cargo": '
    type_of_train = gets.chomp!.to_sym
    if type_of_train == :passenger
      all_trains << PassengerTrain.new(number_of_train)
      p "Succesfully created #{type_of_train} train №:  #{number_of_train}"
    elsif type_of_train == :cargo
      all_trains << CargoTrain.new(number_of_train)
      p "Succesfully created #{type_of_train} train №:  #{number_of_train}"
    else
      p "Wrong type #{type_of_train}"
    end

  when name == '3'
    all_stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
    print 'Type index of starting station: '
    number_of_ss = gets.chomp!.to_i
    print 'Type index of end station: '
    number_of_es = gets.chomp!.to_i
    if number_of_ss > number_of_es || all_stations[number_of_ss] == all_stations[number_of_es] ||
       all_stations[number_of_ss].nil? || all_stations[number_of_es].nil?
      p 'Choose stations correct!'
    else
      all_routes << Route.new(all_stations[number_of_ss], all_stations[number_of_es])
      p 'Route succesfully created'
    end

  when name == '4'
    all_routes.each_with_index { |val, index| p "#{index}: Start at: #{val.starting_station.station_name}." +
                                "  Finish: #{val.end_station.station_name}" }
    print 'Type number of route to add station to it: '
    route_choice = gets.chomp!.to_i

    if all_routes[route_choice]
      all_stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
    else
      p "Wrong parameters #{route_choice}"
    end
    print 'Type number of station to add it to the route: '
    station_choice = gets.chomp!.to_i
    p 'Also choose position in current route to insert in: '
    all_routes[route_choice].list_of_stations.each_with_index { |val, index| p "#{index}:  #{val.station_name}" }
    position = gets.chomp!.to_i

    if all_stations[station_choice]
      all_routes[route_choice].add_route_station(all_stations[station_choice], position)
      p 'Succesfully added station'
      all_routes[route_choice].list_of_stations.each_with_index { |val, index| p "#{index}:  #{val.station_name}" }
    else
      p 'Wrong parameters!'
    end

  when name == '5'
    all_routes.each_with_index { |val, index| p "#{index}: Start at:   #{val.starting_station.station_name} " +
        "Finish at:   #{val.end_station.station_name}" }
    print 'Type number of route to delete station from it: '
    route_choice = gets.chomp!.to_i

    if all_routes[route_choice]
      all_routes[route_choice].stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
    else
      p "Wrong parameters #{route_choice}"
    end
    print 'Type number of station to delete it from the route: '
    station_choice = gets.chomp!.to_i

    if all_routes[route_choice].stations[station_choice]
      all_routes[route_choice].del_route_station(all_routes[route_choice].stations[station_choice])
      p 'Succesfully deleted station'
      all_routes[route_choice].list_of_stations.each_with_index { |val, index| p "#{index}:  #{val.station_name}" }
    else
      p "Wrong parameters! #{station_choice}"
    end

  when name =='6'
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}" }
    p 'Choose train: '
    train_choice = gets.chomp!.to_i
    if all_trains[train_choice]
      all_routes.each_with_index { |val, index| p "#{index}: Start at:   #{val.starting_station.station_name} " +
                                                      "   Finish at:   #{val.end_station.station_name}" }
      p 'Choose route to be add: '
      route_choice = gets.chomp!.to_i
    else
      p "Wrong parameters! #{train_choice}"
    end
    if all_routes[route_choice]
      all_trains[train_choice].add_route(all_routes[route_choice])
      p "Succesfully added route to train №:  #{all_trains[train_choice].number} "
    else
      p "Wrong parameters! #{route_choice}"
    end

  when name == '7'
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}" }
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p 'Enter type of wagon: '
    wagon_choice = gets.chomp!.to_sym
    if wagon_choice == :passenger
      p 'Enter passenger wagon number: '
      wagon_number_choice = gets.chomp!.to_i
      new_wagon = PassengerWagon.new
      new_wagon.change_wagon_number(wagon_number_choice)
      if new_wagon.type_wagon == all_trains[train_choice].type
        all_trains[train_choice].attach_wagon(new_wagon)
        p "Succesfully added #{wagon_choice} wagon №: #{wagon_number_choice}"
      else
        p "Type error"
      end
    elsif wagon_choice == :cargo
      p 'Enter cargo wagon number: '
      wagon_number_choice = gets.chomp!.to_i
      new_wagon = CargoWagon.new
      new_wagon.change_wagon_number(wagon_number_choice)
      if new_wagon.type_wagon == all_trains[train_choice].type
        all_trains[train_choice].attach_wagon(new_wagon)
        p "Succesfully added #{wagon_choice} wagon №: #{wagon_number_choice}"
      else
        p "Type error"
      end
    else
      p "Wrong parameters #{wagon_choice}"
    end

  when name == '8'
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}" }
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p "Wrong parameters: #{train_choice}" if all_trains[train_choice].nil?
    all_trains[train_choice].wagons.each_with_index { |val, index| p "#{index}: #{val.wagon_number}" }
    p 'Enter index of wagon to delete: '
    wagon_number_choice = gets.chomp!.to_i
    if all_trains[train_choice].wagons[wagon_number_choice]
      all_trains[train_choice].detach_wagon(all_trains[train_choice].wagons[wagon_number_choice])
      p "Succesfully detached wagon №: #{wagon_number_choice}"
    else
      p "Wrong parameters: #{train_choice}, #{wagon_number_choice}"
    end

  when name == '9'
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}" }
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p "Wrong parameter of train index: #{train_choice}" if all_trains[train_choice].nil?
    if all_trains[train_choice].current_station == all_trains[train_choice].route.end_station
      p "You are already at final destination #{all_trains[train_choice].current_station.station_name}"
    else
      all_trains[train_choice].send :move_next_station
      p "Succesfully move to station #{all_trains[train_choice].current_station.station_name}"
    end

  when name == '10'
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}" }
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p "Wrong parameter of train index: #{train_choice}" if all_trains[train_choice].nil?
    if all_trains[train_choice].current_station == all_trains[train_choice].route.starting_station
      p "You are already at start destination #{all_trains[train_choice].current_station.station_name}"
    else
      all_trains[train_choice].send :move_back_station
      p "Succesfully move to station #{all_trains[train_choice].current_station.station_name}"
    end

  when name == '11'
    all_routes.each_with_index { |val, index| p "#{index}: Start at:   #{val.starting_station.station_name} " +
                                                    "Finish at:   #{val.end_station.station_name}" }
    print 'Type number of route to see list of all stations in the route: '
    route_choice = gets.chomp!.to_i
    if all_routes[route_choice]
      all_routes[route_choice].list_of_stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
    else
      p "Wrong parameters: #{route_choice}"
      next
    end

  when name == '12'
    all_stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
    p 'Choose station: '
    station_choice = gets.chomp!.to_i
    p 'There is no trains at station you choose. Try another station.' unless all_stations[station_choice].trains.any?
    if all_stations[station_choice]
      all_stations[station_choice].trains.each_with_index { |val, index| p "#{index}: Train № #{val.number}" }
    else
      p "Wrong parameters: #{station_choice}"
    end

  end
end while name != 'exit'

# Для проверки
p all_trains
p all_stations
p all_routes
