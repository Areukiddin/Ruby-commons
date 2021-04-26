# frozen_string_literal: false

# ./train.rb
class Train
  attr_accessor :cars, :current_station, :route
  attr_reader :speed, :number, :type

  def initialize(number, type, cars)
    @number = number
    @type = type
    @cars = cars
    @speed = 0
  end

  def increase_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def hook_car
    @cars += 1 if @speed.zero?
  end

  def unhook_car
    @cars -= 1 if @speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.train_arrival(self)
  end

  def move_forward
    return unless next_station

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
end
