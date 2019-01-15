require File.dirname(__dir__) + '/lib/rental'
require File.dirname(__dir__) + '/lib/input_data_parser'

module Level2
  class Main < InputDataParser
    def run
      {
        rentals: rentals.map do |rental|
          { id: rental.id, price: rental.price }
        end
      }.to_json
    end
  end
end

puts Level2::Main.new('level2').run
