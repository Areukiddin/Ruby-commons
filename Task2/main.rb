require_relative './station'
require_relative './route'
require_relative './train'
require_relative './cargo_train'
require_relative './pass_train'
require_relative './car'
require_relative './cargo_car'
require_relative './pass_car'

class Main
  attr_reader :stations, :route, :cars

  def initialize
    @stations = []
    @trains = []
    @cars = []
  end

  def main
    loop do
      system('clear')
      main_menu
      first_command = command
      break if first_command == 'q'

      case first_command
      when 'cs'
        option(menu_create_station)
      when 'cct'
        option(menu_create_cargo_train)
      when 'cpt'
        option(menu_create_passenger_train)
      when 'cl'
        option(menu_cars_list)
      when 'cr'
        option(menu_create_route)
      when 'as'
        option(menu_add_station)
      when 'ds'
        option(menu_delete_station)
      when 'ar'
        option(menu_add_route)
      when 'ccc'
        option(menu_create_cargo_car)
      when 'fc'
        option(menu_fill_capacity)
      when 'cpc'
        option(menu_create_passenger_car)
      when 'tp'
        option(menu_take_place)
      when 'h'
        option(menu_hook_car)
      when 'uh'
        option(menu_unhook_car)
      when 'forw'
        option(menu_move_forward)
      when 'tow'
        option(menu_move_toward)
      when 'check_st'
        option(menu_show_stations)
      when 'check_tr'
        option(menu_show_trains_on_station)
      else
        option(wrong)
      end
    end
  end

# Users will using text interface, so no need to show all methods

private

  def hash_pass(car)
    { number: car.number, type: car.type, free_places: car.free_places, busy_places: car.busy_places }
  end

  def hash_cargo(car)
    { number: car.number, type: car.type, empty_capacity: car.empty_capacity, filled_capacity: car.filled_capacity }
  end

  def menu_create_station
    puts 'Enter station name'
    name = gets.chomp.to_sym
    @stations << Station.new(name)
    puts "#{name} station created"
  end

  def menu_create_cargo_train
    begin
      puts 'Enter cargo train number'
      number = gets.chomp.to_sym
      @trains << CargoTrain.new(number)
      puts "Cargo train №#{number} created"
      show_trains
    rescue StandardError
      puts 'Invalid train number, try again'
      retry
    end
  end

  def menu_create_passenger_train
    begin
      puts 'Enter passenger train number'
      number = gets.chomp.to_sym
      @trains << PassengerTrain.new(number)
      puts "Passenger train №#{number} created"
      show_trains
    rescue StandardError
      puts 'Invalid train number, try again'
      retry
    end
  end

  def menu_cars_list
    puts 'Enter train number'
    number = gets.chomp.to_sym
    train = find_train(number)
    puts train
    train.scan_cars { |car| car_hash = hash_pass(car); puts car_hash } if train.type.eql?(:passenger)
    train.scan_cars { |car| car_hash = hash_cargo(car); puts car_hash } if train.type.eql?(:cargo)
  end

  def menu_create_route
    puts 'Enter first station'
    first_name = gets.chomp.to_sym
    first_station = find_station(first_name)
    puts 'Station found' if first_station
    puts 'Enter last station'
    last_name = gets.chomp.to_sym
    last_station = find_station(last_name)
    puts 'Station found' if last_station
    @route = Route.new(first_station, last_station) if first_station && last_station
    show_route
  end

  def menu_add_station
    puts 'Enter station name'
    name = gets.chomp.to_sym
    @route.add_station(Station.new(name))
    puts "#{name} station was added to route"
    show_route
  end

  def menu_delete_station
    puts 'Enter station name'
    name = gets.chomp.to_sym
    station = find_route_station(name)
    @route.delete_station(station)
    puts "#{name} station was deleted from route"
    show_route
  end

  def menu_add_route
    puts 'Enter train number'
    number = gets.chomp.to_sym
    find_train(number).add_route(@route)
    show_trains
  end

  def menu_create_cargo_car
    puts 'Enter car number'
    number = gets.chomp.to_sym
    puts 'Enter capacity'
    capacity = gets.chomp.to_i
    @cars << CargoCar.new(number, capacity)
    show_cars
  end

  def menu_fill_capacity
    puts 'Enter car number'
    number = gets.chomp.to_sym
    car = find_car(number)
    puts 'Enter capacity you want to fill'
    capacity = gets.chomp.to_i
    car.fill(capacity)
    puts "Filled capacity: #{car.filled_capacity}"
    puts "Empty capacity: #{car.empty_capacity}"
  end

  def menu_create_passenger_car
    puts 'Enter car number'
    number = gets.chomp.to_sym
    puts 'Enter places'
    places = gets.chomp.to_i
    @cars << PassengerCar.new(number, places)
    show_cars
  end

  def menu_take_place
    puts 'Enter car number'
    number = gets.chomp.to_sym
    car = find_car(number)
    car.take_place
    puts "Busy places: #{car.busy_places}"
    puts "Free places left: #{car.free_places}"
  end

  def menu_hook_car
    puts 'Enter train number'
    puts 'Car type must be the same as train type'
    train_number = gets.chomp.to_sym
    puts 'Enter car number you want to hook'
    car_number = gets.chomp.to_sym
    find_train(train_number).hook_car(find_car(car_number))
    show_trains
  end

  def menu_unhook_car
    puts 'Enter train number'
    train_number = gets.chomp.to_sym
    puts 'Enter car number you want to unhook'
    car_number = gets.chomp.to_sym
    find_train(train_number).unhook_car(find_car(car_number))
    show_trains
  end

  def menu_move_forward
    puts 'Enter train number'
    number = gets.chomp.to_sym
    find_train(number).move_forward
    show_trains
  end

  def menu_move_toward
    puts 'Enter train number'
    number = gets.chomp.to_sym
    find_train(number).move_toward
    show_trains
  end

  def menu_show_stations
    puts "#{@stations}"
  end

  def menu_show_trains_on_station
    puts 'Enter station name'
    name = gets.chomp.to_sym
    puts "#{trains_list(name)}"
  end

  def find_station(name)
    @stations.find { |station| station.name.eql?(name) }
  end

  def find_route_station(name)
    @route.stations.find { |station| station.name.eql?(name) }
  end

  def trains_list(name)
    station = find_station(name)
    station.scan_trains { |train| train_hash = { number: train.number, type: train.type, cars: train.cars.count }; puts train_hash }
  end

  def command
    puts 'Type a command'
    gets.chomp.downcase
  end

  def wrong
    puts 'Wrong command'
  end

  def option(menu_option)
    menu_option
    gets
  end

  def show_route
    puts "#{@route.stations}"
  end

  def show_trains
    puts "#{@trains}"
  end

  def show_cars
    puts "#{@cars}"
  end

  def find_train(number)
    @trains.find { |train| train.number.eql?(number) }
  end

  def find_car(number)
    @cars.find { |car| car.number.eql?(number) }
  end

  def main_menu
    puts 'Controls commands:
      q - quit
      cs - create station
      cct - create cargo train
      cpt - create passenger train
      cl - cars list
      cr - create route
      as - add station
      ds - delete station
      ar - add route
      ccc - create cargo car
      fc - fill capacity
      cpc - create passenger car
      tp - take place
      h - hook car
      uh - unhook car
      forw - move forward
      tow - moce toward
      check_st - check stations
      check_tr - check trains on station'
  end
end

main = Main.new
main.main
