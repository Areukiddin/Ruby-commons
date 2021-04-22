require_relative 'instance_counter'

class CargoTrain < Train
  include InstanceCounter
  def initialize(number, type = :cargo)
    super
  end
end
