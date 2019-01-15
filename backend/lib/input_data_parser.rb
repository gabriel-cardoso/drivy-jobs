require 'json'
require File.dirname(__dir__) + '/lib/car'
require File.dirname(__dir__) + '/lib/rental'

class InputDataParser
  def initialize level_dir
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

  def cars
    @cars ||= json['cars'].reduce({}) do |hash, car|
      hash.update(car['id'] =>
        Car.new(car['id'], car['price_per_day'], car['price_per_km'])
      )
    end
  end

  def rentals
    @rentals ||= json['rentals'].map do |rental|
      car = cars[rental['car_id']]
      Rental.new(
        rental['id'],
        car,
        rental['start_date'],
        rental['end_date'],
        rental['distance']
      )
    end
  end

  def output_results
    puts run
  end
end
