require_relative 'produced_by'
require_relative 'accessors'
require_relative 'validation'

class Car
  include ProducedBy
  include Validation
  include Accessors
  attr_accessor_with_history :type
  strong_attr_accessor :number, Integer

  validate :type, :type, String

  def initialize(number, type, _ = nil)
    @number = number
    @type = type
    validate!
  end
end
