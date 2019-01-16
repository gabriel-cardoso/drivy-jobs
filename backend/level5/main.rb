require File.dirname(__dir__) + '/lib/money_dispatcher'
require File.dirname(__dir__) + '/lib/input_data_parser'

module Level5
  class Main < InputDataParser
    def run
      {
        rentals: rentals.map do |rental|
          {
            id: rental.id,
            options: rental.options.map(&:type),
            actions: MoneyDispatcher.new(rental).actions
          }
        end
      }.to_json
    end
  end
end

puts Level5::Main.new('level5').run
