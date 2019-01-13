require 'json'
require File.dirname(__FILE__) + '/../lib/car'
require File.dirname(__FILE__) + '/../lib/rental'

module Level1
  class Main
    def self.run
      input_file = File.read(File.dirname(__FILE__) + '/data/input.json')
      json = JSON.parse(input_file)

      cars = json['cars'].reduce({}) do |hash, car|
        hash.update(car['id'] =>
          Car.new(car['id'], car['price_per_day'], car['price_per_km'])
        )
      end

      rentals = {}
      rentals[:rentals] = json['rentals'].map do |rental|
        car = cars[rental['car_id']]
        rental = Rental.new(rental['id'], car, rental['start_date'], rental['end_date'], rental['distance'])
        { id: rental.id, price: rental.price }
      end

      rentals.to_json
    end
  end
end

puts Level1::Main.run
