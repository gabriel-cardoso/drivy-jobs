# A class that can create rental option instance for a given type
class RentalOptionFactory
  def self.create(type)
    case type
    when 'gps'
      GPSOption.new
    when 'baby_seat'
      BabySeatOption.new
    when 'additional_insurance'
      AdditionalInsuranceOption.new
    end
  end
end

# Rental option parent class
class RentalOption
  attr_reader :type, :amount_per_day
end

class OwnerOption < RentalOption; end
class DrivyOption < RentalOption; end

class GPSOption < OwnerOption
  def initialize
    @type = 'gps'
    @amount_per_day = 500
  end
end

class BabySeatOption < OwnerOption
  def initialize
    @type = 'baby_seat'
    @amount_per_day = 200
  end
end

class AdditionalInsuranceOption < DrivyOption
  def initialize
    @type = 'additional_insurance'
    @amount_per_day = 1000
  end
end
