require 'pry'
class Enrollment
  attr_accessor :name, :kindergarten_participation

    def initialize(input)
      @name = input[:name]
      @kindergarten_participation = input[:kindergarten_participation]
    end

    def kindergarten_participation_by_year
      kp = kindergarten_participation
      kp.update(kp) do |key, v|
        v.to_s[0..4].to_f
      end
    end

    def kindergarten_participation_in_year(year)
      kp = kindergarten_participation[year]
      kp.to_s[0..4].to_f
    end
end
