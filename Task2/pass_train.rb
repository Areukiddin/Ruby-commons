require_relative 'instance_counter'

class PassengerTrain < Train
  include InstanceCounter
  def initialize(number, type = :passenger)
    super
  end
end
