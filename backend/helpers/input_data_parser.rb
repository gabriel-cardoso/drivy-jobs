require 'json'

module Helpers
  module InputDataParser
    def json
      input_file = File.read(File.dirname(__dir__) + '/data/input.json')
      JSON.parse(input_file)
    end

    def cars
      @cars ||= json['cars'].reduce({}) do |hash, car|
        hash.update(car['id'] =>
          Car.new(car['id'], car['price_per_day'], car['price_per_km'])
        )
      end
    end
  end
end
