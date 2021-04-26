require_relative 'produced_by'

class Car
  include ProducedBy
  attr_reader :number, :type

  def initialize(number, _, type)
    @number = number
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise "Number can't be blank" if number.nil?
    raise "Type can't be blank" if type.length.zero?
    raise 'Number should be at least 6 symbols' if number.to_s.length < 6
  end
end
