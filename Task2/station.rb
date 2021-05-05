require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Accessors
  include Validation
  attr_accessor :trains

  NAME_FORMAT = /^[a-z]+-?[0-9]{1}$/i.freeze

  strong_attr_accessor :code, Integer
  validate :name, :format, NAME_FORMAT

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

  def scan_trains(&block)
    @trains.each { |train| block.call(train) }
  end
end
