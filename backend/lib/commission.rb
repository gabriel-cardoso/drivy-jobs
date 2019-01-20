# Class in charge of computing commission fees for a given rental
class Commission
  def initialize(rental)
    @rental = rental
  end

  # Commission total
  def total
    @total ||= (@rental.price * 0.3).to_i
  end

  def insurance_fee
    @insurance_fee ||= (total * 0.5).to_i
  end

  def assistance_fee
    @assistance_fee ||= 100 * @rental.days
  end

  def drivy_fee
    total - insurance_fee - assistance_fee
  end
end
