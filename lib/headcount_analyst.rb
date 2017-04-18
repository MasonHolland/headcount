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

    def kindergarten_participation_rate_variation_trend(region_a, region_b)
      find_district = @district_repository.find_by_name(region_a)
      find_against = @district_repository.find_by_name(region_b[:against])
      a = find_district.enrollment.kindergarten_participation_by_year.sort.to_h
      b = find_against.enrollment.kindergarten_participation_by_year.sort.to_h
      c = a.merge(b){|key, oldval, newval| (oldval / newval).to_s[0..4].to_f}
    end

    def high_school_graduation_rate_variation(region_a, region_b)
      find_district = @district_repository.find_by_name(region_a)
      find_against = @district_repository.find_by_name(region_b[:against])
      baseline = @district_repository.find_by_name(region_a).enrollment.graduation_rate_by_year.values.reduce(:+)/11
      against = @district_repository.find_by_name(region_b[:against]).enrollment.graduation_rate_by_year.values.reduce(:+)/11
      (baseline / against).to_s[0..4].to_f
    end

    def kindergarten_participation_against_high_school_graduation(district)
      against = {:against => 'COLORADO'}
      a = kindergarten_participation_rate_variation(district, against)
      b = high_school_graduation_rate_variation(district, against)
      (a/b).to_s[0..4].to_f
    end

    def kindergarten_participation_correlates_with_high_school_graduation(district)
       kpaghsg = kindergarten_participation_against_high_school_graduation(district)
      if kpaghsg >= 0.6 && kpaghsg <= 1.5
        true
      else
        false
      end
    end
end
