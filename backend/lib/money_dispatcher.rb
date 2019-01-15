require File.dirname(__dir__) + '/lib/commission'

class MoneyDispatcher
  def initialize rental
    @rental = rental
    @commission = Commission.new(rental)
  end

  def actions
    [driver_debit, owner_credit] + commission_actions
  end

  def driver_debit
    { who: 'driver', type: 'debit', amount: @rental.price }
  end

  def owner_credit
    { who: 'owner', type: 'credit', amount: @rental.price - @commission.total }
  end

  def commission_actions
    %w[insurance assistance drivy].map do |who|
      { who: who, type: 'credit', amount: @commission.send("#{who}_fee") }
    end
  end
end
