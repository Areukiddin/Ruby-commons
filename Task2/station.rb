require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains

  NAME_FORMAT = /^[a-zа-я]+-?[0-9]+$/i.freeze

  class << self
    attr_reader :all

    def add_instance
      @all ||= []
    end
  end

  def initialize(name)
    @name = name
    validate!
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise "Station name can't be blank" if name.length.zero?
    raise "Name length can't be less then 4" if name.length < 4
    raise 'Invalid name format' if name !~ NAME_FORMAT
  end
end
