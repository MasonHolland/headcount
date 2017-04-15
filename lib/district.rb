require_relative 'district_repository'

class District
  attr_reader :name

    def initialize(input)
      @name = input[:name]
      @repo = input[:repo]
    end

    def enrollment
      distrepo = @repo
      current_name = name
      distrepo.enrollment_repository.find_by_name(current_name)
    end

end
