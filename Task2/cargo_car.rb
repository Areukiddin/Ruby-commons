class CargoCar < Car
  attr_reader :empty_capacity, :filled_capacity

  def initialize(number, capacity, type = :cargo)
    super
    @empty_capacity = capacity
    @filled_capacity = 0
  end

  def fill(capacity)
    return unless @empty_capacity >= capacity

    @empty_capacity -= capacity
    @filled_capacity += capacity
  end
end
