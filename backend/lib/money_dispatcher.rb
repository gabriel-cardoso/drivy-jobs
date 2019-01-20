require File.dirname(__dir__) + '/lib/commission'

# A class in charge of dispatching money for a given rental
class MoneyDispatcher
  def initialize(rental)
    @rental = rental
    @commission = Commission.new(rental)
  end

  # Returns an array of hash representing transation actions
  def actions
    [driver_debit, owner_credit] + commission_actions + [drivy_credits]
  end

  # Returns driver debit action
  def driver_debit
    { who: 'driver', type: 'debit', amount: @rental.price_with_options }
  end

  # Returns owner credit action
  def owner_credit
    amount = @rental.price - @commission.total + @rental.owner_options_price
    { who: 'owner', type: 'credit', amount: amount }
  end

  # Returns commisions actions (except Drivy's)
  def commission_actions
    %w[insurance assistance].map do |who|
      { who: who, type: 'credit', amount: @commission.send("#{who}_fee") }
    end
  end

  # Returns Drivy's credit action
  def drivy_credits
    amount = @commission.drivy_fee + @rental.drivy_options_price
    { who: 'drivy', type: 'credit', amount: amount }
  end
end
