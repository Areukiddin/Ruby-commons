# frozen_string_literal: false

# ./route.rb
class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = []
    @stations << first_station
    @stations << last_station
  end

  def add_station(station)
    @stations.insert((@stations.length - 1), station) unless @stations.include?(station)
  end

  def delete_station(station)
    @stations.delete(station) unless station.eql?(@stations.first) || station.eql?(@stations.last)
  end
end
