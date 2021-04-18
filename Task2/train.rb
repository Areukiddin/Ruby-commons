# frozen_string_literal: false

# ./train.rb
class Train
  attr_accessor :current_station, :route
  attr_reader :speed, :number, :type, :cars

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
  end

  def increase_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def hook_car(car)
    @cars << car if able_to_hook(car)
  end

  def unhook_car(car)
    @cars.delete(car) if able_to_unhook
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.train_arrival(self)
  end

  def move_forward
    return unless next_station && self.route.nil?

    @current_station.train_departure(self)
    @current_station = next_station
    @current_station.train_arrival(self)
  end

  def move_toward
    return unless previous_station

    @current_station.train_departure(self)
    @current_station = previous_station
    @current_station.train_arrival(self)
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station.eql?(@route.stations.first)
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station.eql?(@route.stations.last)
  end

  protected

  # support methods, no need to be available in interface
  def able_to_unhook
    @speed.zero? && @cars.length.positive?
  end

  def able_to_hook(car)
    @speed.zero? && self.type.eql?(car.type)
  end
end
