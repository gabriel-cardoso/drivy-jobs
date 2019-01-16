require File.dirname(__dir__) + '/lib/commission'

class MoneyDispatcher
  def initialize(rental)
    @rental = rental
    @commission = Commission.new(rental)
  end

  def actions
    [driver_debit, owner_credit] + commission_actions + [drivy_credits]
  end

  def driver_debit
    { who: 'driver', type: 'debit', amount: @rental.price_with_options }
  end

  def owner_credit
    amount = @rental.price - @commission.total + @rental.owner_options_price
    { who: 'owner', type: 'credit', amount: amount }
  end

  def commission_actions
    %w[insurance assistance].map do |who|
      { who: who, type: 'credit', amount: @commission.send("#{who}_fee") }
    end
  end

  def drivy_credits
    amount = @commission.drivy_fee + @rental.drivy_options_price
    { who: 'drivy', type: 'credit', amount: amount }
  end
end
