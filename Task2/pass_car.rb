class PassengerCar < Car
  attr_reader :free_places, :busy_places

  def initialize(number, places, type = :passenger)
    @free_places = places
    @busy_places = 0
    super
  end

  def take_place
    return if @free_places.zero?

    @free_places -= 1
    @busy_places += 1
  end
end
