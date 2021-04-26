require_relative 'instance_counter'
require_relative 'produced_by'

class Route
  include InstanceCounter
  attr_accessor :stations

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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise "First station wasn't found/wrong argument type" unless @stations.first.instance_of?(Station)
    raise "Last station wasn't found/wrong argument type" unless @stations.last.instance_of?(Station)
  end
end
