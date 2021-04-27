require_relative 'instance_counter'
require_relative 'produced_by'

class Train
  include InstanceCounter
  include ProducedBy
  attr_accessor :current_station, :route
  attr_reader :speed, :number, :type, :cars

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  class << self
    attr_reader :trains

    def add_train
      @trains ||= []
    end

    def find(number)
      result = @trains.filter { |train| train.number.eql?(number) }
      result || nil
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @speed = 0
    @cars = []
    register_instance
    self.class.add_train << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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

  def scan_cars(&block)
    @cars.each { |car| block.call(car) }
  end

  protected

  def validate!
    raise "Number can't be blank" if number.nil?
    raise 'Invalid number format' if number !~ NUMBER_FORMAT
    raise "Type can't be blank" if type.length.zero?
  end

  # support methods, no need to be available in interface
  def able_to_unhook
    @speed.zero? && @cars.length.positive?
  end

  def able_to_hook(car)
    @speed.zero? && self.type.eql?(car.type)
  end
end
