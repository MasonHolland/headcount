class District

  attr_reader :name

  def initialize(input, district_repo = nil)
    @name = input[:name]
    @dr = district_repo
  end

end
