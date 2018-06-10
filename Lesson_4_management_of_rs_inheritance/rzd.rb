class Rzd

  attr_reader :all_trains, :all_routes, :all_stations

  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def start
    begin
      name = main_menu
      case
      when name == 1
        add_station
      when name == 2
        add_train
      when name == 3
        create_route
      when name == 4
        add_station_to_route
      when name == 5
        del_station_from_the_route
      when name == 6
        attach_route_to_train
      when name == 7
        attach_wagon
      when name == 8
        detach_wagon
      when name == 9
        move_train_forward
      when name == 10
        move_train_backward
      when name == 11
        all_stations_list
      when name == 12
        all_trains_in_station
      when name == 13
        p wagons_of_train
      when name == 14
        p trains_of_station
      when name == 15
        seat_or_load_wagon
      end
    end while name != 0

    # Для проверки
    p all_trains
    p all_stations
    p all_routes
  end

  # Помещены методы не относящиеся к интерфейсу пользователя
  private

  def main_menu
    p 'Choose action: '
    p "Type '1' if u want to create station"
    p "Type '14' if u want to see all trains in station u choose (Block Edition)" if all_stations.any?
    p "Type '12' if u want to see all trains in some station" if all_stations.any?
    p "Type '2' if u want to create train"
    p "Type '15' to take a seat / load in wagon u choose" if all_trains.any?
    p "Type '13' if u want to see wagons of train u choose" if all_trains.any?
    p "Type '9' if u want to move forward" if all_routes.any? && all_trains.any?
    p "Type '10' if u want to move backward" if all_routes.any? && all_trains.any?
    p "Type '7' if u want to attach wagon to train" if all_trains.any?
    p "Type '8' if u want to detach wagon from train" if all_trains.any?
    p "Type '3' if u want to create route" if all_stations.count >= 2
    p "Type '4' if u want to add station to the route" if all_routes.any?
    p "Type '11' if u want to see list of all stations in some route" if all_routes.any?
    p "Type '5' if u want to delete station from the route" if all_routes.any?
    p "Type '6' if u want to attach route to the train" if all_routes.any? && all_trains.any?
    p "Type '0' to exit program"
    gets.chomp!.to_i
  end

  def add_station
    print 'Type name of the station: '
    station_name = gets.chomp!
    new_st = Station.new(station_name)
    all_stations << new_st
    p 'Station succesfully created'
  rescue RuntimeError => e
    p e.inspect
  end

  def trains_of_station
    show_all_stations
    print 'Choose station first: '
    station = gets.chomp.to_i
    block = ->(station) { station }
    all_stations[station].list_of_trains(block)
  end

  def add_train
    print 'Choose type of train between "passenger" and "cargo": '
    type_of_train = gets.chomp!.to_sym
    print 'Type number of the train: '
    number_of_train = gets.chomp!
    case
    when type_of_train == :passenger
      new_train = PassengerTrain.new(number_of_train)
      p 'Enter passenger wagon number: '
      wagon_number = gets.chomp!.to_i
      print 'Enter total capacity of passenger wagon: '
      total_seats = gets.chomp!.to_i
      new_wagon = PassengerWagon.new(wagon_number, total_seats)
      all_trains << new_train
      print 'Enter passenger train manufacturer: '
      new_train.manufacturer = gets.chomp!
      p "Succesfully created #{type_of_train} train №:  #{number_of_train}"
      print 'Enter passenger wagon manufacturer: '
      new_wagon.manufacturer = gets.chomp!
      new_train.attach_wagon(new_wagon)
      p "Succesfully added passenger wagon №: #{new_wagon.wagon_number}"
    when type_of_train == :cargo
      new_train = CargoTrain.new(number_of_train)
      p 'Enter cargo wagon number: '
      wagon_number = gets.chomp!.to_i
      print 'Enter total capacity of cargo wagon: '
      total_volume = gets.chomp!.to_i
      new_wagon = CargoWagon.new(wagon_number, total_volume)
      all_trains << new_train
      print 'Enter cargo train manufacturer: '
      new_train.manufacturer = gets.chomp!
      p "Succesfully created #{type_of_train} train №:  #{number_of_train}"
      print 'Enter cargo wagon manufacturer: '
      new_wagon.manufacturer = gets.chomp!
      new_train.attach_wagon(new_wagon)
      p "Succesfully added passenger wagon №: #{new_wagon.wagon_number}"
    else
      p "Wrong type #{type_of_train}"
    end
  rescue RuntimeError => e
    p e.inspect
    retry
  end

  def seat_or_load_wagon
    show_all_trains
    print 'Choose train first: '
    train = gets.chomp!.to_i
    all_trains[train].wagons.each_with_index { |w, index| p "#{index}:  № #{ w.wagon_number}" }
    print 'Type wagon index please: '
    wagon_index = gets.chomp!.to_i
    case
    when all_trains[train].type == :cargo
      print 'Type value of load volume: '
      volume = gets.chomp!.to_i
      all_trains[train].wagons[wagon_index].load_wagon(volume)
      p "Succesfully loaded! Volume free: #{all_trains[train].wagons[wagon_index].total_free_volume} "
    when all_trains[train].type == :passenger
      all_trains[train].wagons[wagon_index].take_seat
      p "Succesfully took! Free seats in wagon: #{all_trains[train].wagons[wagon_index].total_free_seats}"
    end

  end

  def wagons_of_train
    show_all_trains
    print 'Choose train first: '
    train = gets.chomp.to_i
    block = ->(wagon) { wagon }
    all_trains[train].list_of_wagons(block)
  end

  def create_route
    show_all_stations
    print 'Type index of starting station: '
    number_of_ss = gets.chomp!.to_i
    print 'Type index of end station: '
    number_of_es = gets.chomp!.to_i
    all_routes << Route.new(all_stations[number_of_ss], all_stations[number_of_es])
    p 'Route succesfully created'
  rescue RuntimeError => e
    p e.inspect
  end

  def show_all_routes
    all_routes.each_with_index { |val, index| p "#{index}: Start at: #{val.starting_station.station_name}." +
                                 "  Finish: #{val.end_station.station_name}" }
  end

  def show_route_stations(route_choice)
    all_routes[route_choice].stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
  end

  def show_all_stations
    all_stations.each_with_index { |val, index| p "#{index}: #{val.station_name}" }
  end

  def show_station_trains(station_choice)
    all_stations[station_choice].trains.each_with_index { |val, index| p "#{index}: Train № #{val.number}" }
  end

  def show_all_trains
    all_trains.each_with_index { |val, index| p "#{index}: #{val.number}  #{val.type}" }
  end

  def add_station_to_route
    show_all_routes
    print 'Type number of route to add station to it: '
    route_choice = gets.chomp!.to_i
    if all_routes[route_choice]
      show_all_stations
    else
      p("Wrong parameters #{route_choice}")
      start
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
  end

  def del_station_from_the_route
    show_all_routes
    print 'Type number of route to delete station from it: '
    route_choice = gets.chomp!.to_i
    all_routes[route_choice] ? show_route_stations(route_choice) : p("Wrong parameters #{route_choice}")
    print 'Type number of station to delete it from the route: '
    station_choice = gets.chomp!.to_i
    if all_routes[route_choice].stations[station_choice]
      all_routes[route_choice].del_route_station(all_routes[route_choice].stations[station_choice])
      p 'Succesfully deleted station'
      show_route_stations(route_choice)
    else
      p "Wrong parameters! #{station_choice}"
    end
  end

  def attach_route_to_train
    show_all_trains
    p 'Choose train: '
    train_choice = gets.chomp!.to_i
    if train_choice.nil? == false || all_trains[train_choice]
      show_all_routes
      p 'Choose route to be add: '
      route_choice = gets.chomp!.to_i
    else
      p "Wrong parameters! #{train_choice}"
      start
    end
    if route_choice.nil? || all_routes[route_choice].nil?
      p "Wrong parameters! #{route_choice}"
    else
      all_trains[train_choice].route = all_routes[route_choice]
      p "Succesfully added route to train №:  #{all_trains[train_choice].number} "
    end
  end

  def attach_wagon
    show_all_trains
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p 'Enter type of wagon: '
    wagon_choice = gets.chomp!.to_sym
    print 'Type number of the wagon: '
    number_of_wagon = gets.chomp!.to_i
    case
    when wagon_choice == :passenger
      print 'Enter total capacity of passenger wagon: '
      total_seats = gets.chomp!.to_i
      new_wagon = PassengerWagon.new(number_of_wagon, total_seats)
      if new_wagon.type_wagon == all_trains[train_choice].type
        all_trains[train_choice].attach_wagon(new_wagon)
        p "Succesfully added #{wagon_choice} wagon №: #{new_wagon.wagon_number}"
      else
        p "Type error"
      end
    when wagon_choice == :cargo
      print 'Enter total capacity of cargo wagon: '
      total_volume = gets.chomp!.to_i
      new_wagon = CargoWagon.new(number_of_wagon, total_volume)
      if new_wagon.type_wagon == all_trains[train_choice].type
        all_trains[train_choice].attach_wagon(new_wagon)
        p "Succesfully added #{wagon_choice} wagon №: #{new_wagon.wagon_number}"
      else
        p "Type error"
      end
    else
      p "Wrong parameters #{wagon_choice}"
    end
  end

  def detach_wagon
    show_all_trains
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    if all_trains[train_choice].nil?
      p "Wrong parameters: #{train_choice}"
      start
    end
    all_trains[train_choice].wagons.each_with_index { |val, index| p "#{index}: #{val.wagon_number}" }
    p 'Enter index of wagon to delete: '
    wagon_number_choice = gets.chomp!.to_i
    if all_trains[train_choice].wagons[wagon_number_choice]
      all_trains[train_choice].detach_wagon(all_trains[train_choice].wagons[wagon_number_choice])
      p "Succesfully detached wagon №: #{wagon_number_choice}"
    else
      p "Wrong parameters: #{train_choice}, #{wagon_number_choice}"
    end
  end

  def move_train_forward
    show_all_trains
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p "Wrong parameter of train index: #{train_choice}" if all_trains[train_choice].nil?
    if all_trains[train_choice].current_station == all_trains[train_choice].route.end_station
      p "You are already at final destination #{all_trains[train_choice].current_station.station_name}"
    else
      all_trains[train_choice].move_next_station
      p "Succesfully move to station #{all_trains[train_choice].current_station.station_name}"
    end
  end

  def move_train_backward
    show_all_trains
    p 'Enter index of train: '
    train_choice = gets.chomp!.to_i
    p "Wrong parameter of train index: #{train_choice}" if all_trains[train_choice].nil?
    if all_trains[train_choice].current_station == all_trains[train_choice].route.starting_station
      p "You are already at start destination #{all_trains[train_choice].current_station.station_name}"
    else
      all_trains[train_choice].move_back_station
      p "Succesfully move to station #{all_trains[train_choice].current_station.station_name}"
    end
  end

  def all_stations_list
    show_all_routes
    print 'Type number of route to see list of all stations in the route: '
    route_choice = gets.chomp!.to_i
    if all_routes[route_choice]
      show_route_stations(route_choice)
    else
      p "Wrong parameters: #{route_choice}"
      start
    end
  end

  def all_trains_in_station
    show_all_stations
    p 'Choose station: '
    station_choice = gets.chomp!.to_i
    p 'There is no trains at station you choose. Try another station.' unless all_stations[station_choice].trains.any?
    if all_stations[station_choice]
      show_station_trains(station_choice)
    else
      p "Wrong parameters: #{station_choice}"
    end
  end
end
