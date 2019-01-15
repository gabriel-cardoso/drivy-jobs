require File.dirname(__dir__) + '/lib/commission'
require File.dirname(__dir__) + '/lib/input_data_parser'

module Level3
  class Main < InputDataParser
    def run
      {
        rentals: rentals.map do |rental|
          commission = Commission.new(rental)
          {
            id: rental.id,
            price: rental.price,
            commission: {
              insurance_fee: commission.insurance_fee,
              assistance_fee: commission.assistance_fee,
              drivy_fee: commission.drivy_fee
            }
          }
        end
      }.to_json
    end
  end
end

puts Level3::Main.new('level3').run
