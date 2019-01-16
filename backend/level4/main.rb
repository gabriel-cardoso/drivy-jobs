require File.dirname(__dir__) + '/lib/money_dispatcher'
require File.dirname(__dir__) + '/lib/input_data_parser'

module Level4
  class Main < InputDataParser
    def run
      {
        rentals: rentals.map do |rental|
          {
            id: rental.id,
            actions: MoneyDispatcher.new(rental).actions
          }
        end
      }.to_json
    end
  end
end

puts Level4::Main.new('level4').run
