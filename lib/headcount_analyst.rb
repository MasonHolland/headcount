require_relative "district"
require 'pry'
require './test/test_helper'

class HeadcountAnalyst
  
  attr_reader :district_repository

    def initialize(district_repository)
      @district_repository = district_repository
    end

    def kindergarten_participation_rate_variation(region_a, region_b)
      # binding.pry
      baseline = @district_repository.find_by_name(region_a).enrollment.kindergarten_participation_by_year.values.reduce(:+)/11
      against = @district_repository.find_by_name(region_b[:region_b]).enrollment.kindergarten_participation_by_year.reduce(:+)/11
      baseline / against
    end
end