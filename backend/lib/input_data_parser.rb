require 'json'
require File.dirname(__dir__) + '/lib/car'
require File.dirname(__dir__) + '/lib/rental'
require File.dirname(__dir__) + '/lib/rental_option'

class InputDataParser
  def initialize(level_dir)
    @input_file = File.read(
      File.join(
        File.dirname(__dir__),
        level_dir,
        '/data/input.json'
      )
    )
  end

  def json
    JSON.parse(@input_file)
  end

  def cars_by_id
    @cars_by_id ||= json['cars'].reduce({}) do |hash, car|
      hash.update(
        car['id'] => Car.new(
          car['id'], car['price_per_day'], car['price_per_km']
        )
      )
    end
  end

  def rentals_by_id
    @rentals_by_id ||= json['rentals'].reduce({}) do |hash, rental|
      car = cars_by_id[rental['car_id']]
      rental_id = rental['id']
      hash.update(
        rental_id => Rental.new(
          rental_id,
          car,
          rental['start_date'],
          rental['end_date'],
          rental['distance'],
          options_by_rental_id[rental_id] || []
        )
      )
    end
  end

  def rentals
    @rentals ||= rentals_by_id.values
  end

  def options_by_rental_id
    return {} if json['options'].nil?

    @options_by_rental_id ||= json['options'].reduce({}) do |hash, option|
      rental_id = option['rental_id']
      options = hash[rental_id] || []
      hash.update(
        rental_id => options + [RentalOption.create(option['type'])]
      )
    end
  end
end
