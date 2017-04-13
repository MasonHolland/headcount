
require 'bigdecimal'
require 'pry'
class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(input, enrollment_repo = nil)
    @name = input[:name]
    @kindergarten_participation = input[:kindergarten_participation]
    @er = enrollment_repo
  end

  def kindergarten_participation_by_year
    # binding.pry
    # kindergarten_participation.each do |k, v|
      # kindergarten_participation[k] = v
      kp = kindergarten_participation
      kp.update(kp) do |key, v|
        v.to_s[0..4].to_f
        # v[0..4]
        # v.to_f
            # value = value.to_s
      # value = value[0..4].to_f
    # end|key, value| valufloor(3)}
      # value.round(3)
    end
  end

  def kindergarten_participation_in_year(year)
    @kindergarten_participation[year]
  end
end
