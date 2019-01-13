require 'date'

class Rental
  attr_reader :id

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = Date.parse start_date
    @end_date = Date.parse end_date
    @distance = distance
  end

  def time
    @time ||= @end_date - @start_date + 1
  end

  def time_price
    @car.price_per_day * time.to_i
  end

  def distance_price
    @car.price_per_km * @distance
  end

  def price
    time_price + distance_price
  end
end
