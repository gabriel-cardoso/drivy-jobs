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

  def days
    @days ||= (@end_date - @start_date).to_i + 1
  end

  def time_price
    @car.price_per_day * days
  end

  def price_for_day day
    return @car.price_per_day * 0.5 if day > 10
    return @car.price_per_day * 0.7 if day > 4
    return @car.price_per_day * 0.9 if day > 1

    @car.price_per_day
  end

  def decreasing_time_price
    (1..days).reduce(0) do |sum, day|
      (sum + price_for_day(day)).to_i
    end
  end

  def distance_price
    @car.price_per_km * @distance
  end

  def full_price
    time_price + distance_price
  end

  def price
    decreasing_time_price + distance_price
  end
end
