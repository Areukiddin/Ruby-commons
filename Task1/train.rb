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
    @route = []
    @current_station = {}
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

  def add_route(stations)
    @route = stations
    @current_station = @route.stations.first
    @route.stations[0].train_arrival(self)
  end

  def move_forward
    return if @current_station.eql?(@route.stations.last)

    @current_station.train_departure(self)
    @route.stations[@route.stations.index(@current_station) + 1].train_arrival(self)
    @current_station = @route.stations[@route.stations.index(@current_station) + 1]
  end

  def move_toward
    return if @current_station.eql?(@route.stations.first)

    @current_station.train_departure(self)
    @route.stations[@route.stations.index(@current_station) - 1].train_arrival(self)
    @current_station = @route.stations[@route.stations.index(@current_station) - 1]
  end

  def surround_stations
    previous_station = @route.stations[@route.stations.index(@current_station) - 1]
    next_station = @route.stations[@route.stations.index(@current_station) + 1]

    if @current_station.eql?(@route.stations.first)
      (return [@current_station, next_station])
    elsif @current_station.eql?(@route.stations.last)
      return [previous_station, @current_station]
    end

    [previous_station, @current_station, next_station]
  end
end
