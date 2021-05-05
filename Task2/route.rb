require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Accessors
  include Validation

  attr_accessor :stations

  attr_accessor_with_history :route_number
  validate :route_number, :presence
  validate :route_number, :type, Integer

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    @stations.delete(station) unless station.eql?(@stations.first) || station.eql?(@stations.last)
  end
end
