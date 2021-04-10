# frozen_string_literal: false

# ./station.rb
class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train) unless @trains.length.zero?
  end

  def trains_by(type)
    @trains.select { |train| train.type.eql?(type) }
  end
end
