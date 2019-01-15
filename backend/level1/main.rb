require File.dirname(__dir__) + '/lib/rental'
require File.dirname(__dir__) + '/lib/input_data_parser'

module Level1
  class Main < InputDataParser
    def run
      {
        rentals: rentals.map do |rental|
          { id: rental.id, price: rental.full_price }
        end
      }.to_json
    end
  end
end

puts Level1::Main.new('level1').run
