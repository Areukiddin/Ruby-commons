# frozen_string_literal: false

# ./car.rb
class Car
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end
end
