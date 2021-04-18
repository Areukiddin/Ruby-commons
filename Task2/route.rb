# frozen_string_literal: false

# ./route.rb
class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    @stations.delete(station) unless station.eql?(@stations.first) || station.eql?(@stations.last)
    puts "#{@stations}"
  end
end
