class Enrollment
  
  attr_reader :name

  def initialize(input, enrollment_repo = nil)
    @name = input[:name]
    @er = enrollment_repo
  end
  
end