require 'pry'
class Enrollment
  attr_accessor :name, :kindergarten_participation, :high_school_graduation

    def initialize(input)
      @name = input[:name]
      @kindergarten_participation = input[:kindergarten_participation]
      @high_school_graduation = input[:high_school_graduation]
    end

    def kindergarten_participation_by_year
      kp = @kindergarten_participation
      kp.update(kp) do |key, v|
        Cleaner.truncate(v)
      end
    end

    def kindergarten_participation_in_year(year)
      kp = @kindergarten_participation[year]
      Cleaner.truncate(kp)
    end

    def graduation_rate_by_year
      hsgrad = @high_school_graduation
      hsgrad.update(hsgrad) do |key, v|
        Cleaner.truncate(v)
      end
    end

    def graduation_rate_in_year(year)
      hsgrad = @high_school_graduation[year]
      Cleaner.truncate(hsgrad)
    end

end
