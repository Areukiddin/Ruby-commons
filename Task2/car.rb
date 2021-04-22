require_relative 'produced_by'

class Car
  include ProducedBy
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end
end
