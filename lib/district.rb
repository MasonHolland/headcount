require_relative 'district_repository'
require_relative 'statewide_test'

class District
  attr_reader :name, :statewide_test

    def initialize(input, repo = nil)
      @name = input[:name]
      @repo = repo
    end

    def enrollment
      @repo.find_enrollment(name)
    end

    def statewide_test
      @repo.statewide_repository.find_statewide_test(@name)
    end

end
