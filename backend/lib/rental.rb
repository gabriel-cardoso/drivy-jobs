require 'date'

# A class representing a rental
class Rental
  attr_reader :id, :options

  def initialize(id, car, start_date, end_date, distance, options = [])
    @id = id
    @car = car
    @start_date = Date.parse start_date
    @end_date = Date.parse end_date
    @distance = distance
    @options = options
  end

  # Returns the number of days of the rental
  def days
    @days ||= (@end_date - @start_date).to_i + 1
  end

  # Returns the amount cost depending on rental duration
  def time_price
    @car.price_per_day * days
  end

  # Returns a price for a given `day`. Applies decreasing policy.
  # `day` corresponds to the index day. It should be included in [1; days]
  def price_for_day(day)
    return @car.price_per_day * 0.5 if day > 10
    return @car.price_per_day * 0.7 if day > 4
    return @car.price_per_day * 0.9 if day > 1

    @car.price_per_day
  end

  # Computes the cost depending on rental duration with decreasing policy
  def decreasing_time_price
    (1..days).reduce(0) do |sum, day|
      (sum + price_for_day(day)).to_i
    end
  end

  # Returns the cost depending on rental distance
  def distance_price
    @car.price_per_km * @distance
  end

  # Returns rental price without decreasing policy on duration
  def full_price
    time_price + distance_price
  end

  # Returns rental price with decreasing policy on duration
  def price
    decreasing_time_price + distance_price
  end

  # Returns the rental price with options
  def price_with_options
    price + options_price
  end

  # Returns options of type OwnerOption
  def owner_options
    @owner_options ||= @options.select { |options| options.is_a? OwnerOption }
  end

  # Returns options of type DrivyOption
  def drivy_options
    @drivy_options ||= @options.select { |options| options.is_a? DrivyOption }
  end

  # Returns owner options total price
  def owner_options_price
    options_price owner_options
  end

  # Returns Drivy's option total price
  def drivy_options_price
    options_price drivy_options
  end

  # Returns options price depending on duration.
  # An optional options array can be passed otherwise @options will be used
  def options_price(options = @options)
    options.map(&:amount_per_day).sum * days
  end
end
