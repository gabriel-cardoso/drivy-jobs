require File.dirname(__dir__) + '/lib/money_dispatcher'

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

puts Level3::Main.new('level3').run
