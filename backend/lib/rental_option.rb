class RentalOption
  attr_reader :type, :amount_per_day
  def self.create(type)
    return GPSOption.new if type == 'gps'
    return BabySeatOption.new if type == 'baby_seat'
    return AdditionalInsurance.new if type == 'additional_insurance'
  end
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

class AdditionalInsurance < DrivyOption
  def initialize
    @type = 'additional_insurance'
    @amount_per_day = 1000
  end
end
