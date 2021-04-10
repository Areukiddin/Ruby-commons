# frozen_string_literal: false

# ./train.rb
class Train
  attr_accessor :cars, :current_station
  attr_writer :route
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
    if @speed.zero?
      @cars += 1
    else puts 'Stop train before hooking car'
    end
  end

  def unhook_car
    if @speed.zero?
      @cars -= 1
    else puts 'Stop train before unhooking car'
    end
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.train_arrival(self)
  end

  def move_forward
    return if @current_station.eql?(@route.stations.last)

    @current_station.train_departure(self)
    @next_station.train_arrival(self)
    @current_station = @route.stations[@route.stations.index(@current_station) + 1]
  end

  def move_toward
    return if @current_station.eql?(@route.stations.first)

    @current_station.train_departure(self)
    @previous_station.train_arrival(self)
    @current_station = @route.stations[@route.stations.index(@current_station) - 1]
  end

  def previous_station
    previous_station = @route.stations[@route.stations.index(@current_station) - 1]
    @previous_station = previous_station unless @current_station.eql?(@route.stations.first)
  end

  def next_station
    next_station = @route.stations[@route.stations.index(@current_station) + 1]
    @next_station = next_station unless @current_station.eql?(@route.stations.last)
  end
end
