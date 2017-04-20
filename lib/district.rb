require_relative 'district_repository'

class District
  attr_reader :name

    def initialize(input, repo = nil)
      @name = input[:name]
      @repo = repo
    end

    def enrollment
      @repo.find_enrollment(name)
    end

    def statewide_test
      @repo.find_statewide_test(@name)
    end

end
