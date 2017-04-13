class Enrollment
  
  attr_reader :name

  def initialize(input, enrollment_repo = nil)
    @name = input[:name]
    @kindergarten_participation = input[:kindergarten_participation]
    @er = enrollment_repo
  end

  def kindergarten_participation_by_year
    @kindergarten_participation
  end

end
