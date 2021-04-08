# frozen_string_literal: false

# ./station.rb
class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_hash(train)
    { number: train.number, type: train.type }
  end

  def train_arrival(train)
    @trains << train_hash(train)
  end

  def train_departure(train)
    @trains.delete(train_hash(train)) unless @trains.length.zero?
  end

  def typed_trains_list(type)
    @trains.select { |train| train[:type] == type }
  end
end
