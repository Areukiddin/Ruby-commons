require_relative 'instance_counter'
require_relative 'produced_by'

class Route
  include InstanceCounter
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    @stations.delete(station) unless station.eql?(@stations.first) || station.eql?(@stations.last)
  end
end
