# frozen_string_literal: false

# ./cargo_train.rb
class CargoTrain < Train
  def initialize(number, type = :cargo)
    @number = number
    super
  end
end
