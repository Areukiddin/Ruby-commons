# frozen_string_literal: false

# ./pass_train.rb
class PassengerTrain < Train
  def initialize(number, type = :passenger)
    @number = number
    super
  end
end
