# frozen_string_literal: false

# ./cargo_car.rb
class CargoCar < Car
  def initialize(number, type = :cargo)
    @number = number
    super
  end
end
