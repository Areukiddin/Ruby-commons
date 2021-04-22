require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains

  class << self
    attr_reader :all

    def add_instance
      @all ||= []
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    self.class.add_instance << self
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
