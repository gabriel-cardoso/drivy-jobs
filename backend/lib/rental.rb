require 'date'

class Rental
  attr_reader :id

  def initialize(id, car, start_date, end_date, distance, decreasing_price = false)
    @id = id
    @car = car
    @start_date = Date.parse start_date
    @end_date = Date.parse end_date
    @distance = distance
    @decreasing_price = @decreasing_price
  end

  def days
    @days ||= (@end_date - @start_date).to_i + 1
  end

  def time_price
    @car.price_per_day * days
  end

  def decreasing_time_price
    (1..days).reduce(0) do |sum, day|
      return sum + @car.price_per_day * 0.5 if day > 10
      return sum + @car.price_per_day * 0.7 if day > 4
      return sum + @car.price_per_day * 0.9 if day > 1
      sum + @car.price_per_day
    end
  end

  def distance_price
    @car.price_per_km * @distance
  end

  def price
    puts @decreasing_price
    (@decreasing_price ? decreasing_time_price : time_price) + distance_price
  end
end
