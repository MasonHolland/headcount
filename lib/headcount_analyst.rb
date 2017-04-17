require_relative "district"
require_relative "district_repository"
require_relative 'enrollment'
require 'pry'
require './test/test_helper'

class HeadcountAnalyst

  attr_reader :district_repository

    def initialize(dis_rep)
      @district_repository = dis_rep
    end

    def kindergarten_participation_rate_variation(region_a, region_b)
      baseline = @district_repository.find_by_name(region_a).enrollment.kindergarten_participation_by_year.values.reduce(:+)/11
      against = @district_repository.find_by_name(region_b[:against]).enrollment.kindergarten_participation_by_year.values.reduce(:+)/11
      (baseline / against).to_s[0..4].to_f
    end
end
