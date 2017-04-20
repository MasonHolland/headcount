require_relative "district"
require_relative "district_repository"
require_relative 'enrollment'
require_relative '../test/test_helper'

class HeadcountAnalyst

  attr_reader :distrepo, :hs, :kg

    def initialize(dis_rep)
      @distrepo = dis_rep
    end

    def drnf(region_x)
      @distrepo.find_by_name(region_x)
    end

    def kindergarten_participation_rate_variation(region_a, region_b)
      baseline = drnf(region_a).enrollment.kindergarten_participation_by_year.values.reduce(:+)/11
      against = drnf(region_b[:against]).enrollment.kindergarten_participation_by_year.values.reduce(:+)/11
      (baseline / against).to_s[0..4].to_f
    end

    def kindergarten_participation_rate_variation_trend(region_a, region_b)
      found_district = drnf(region_a)
      found_against = drnf(region_b[:against])
      a = found_district.enrollment.kindergarten_participation_by_year.sort.to_h
      b = found_against.enrollment.kindergarten_participation_by_year.sort.to_h
      a.merge(b){|key, oldval, newval| (oldval / newval).to_s[0..4].to_f}
    end

    def high_school_graduation_rate_variation(region, state)
      found_district = drnf(region)
      found_state = drnf(state[:against])
      count = found_district.enrollment.graduation_rate_by_year.count
      baseline = found_district.enrollment.graduation_rate_by_year.values.reduce(:+)/count
      against = found_state.enrollment.graduation_rate_by_year.values.reduce(:+)/count
      (baseline / against).to_s[0..4].to_f
    end

    def kindergarten_participation_against_high_school_graduation(district)
      against = {:against => 'COLORADO'}
      kg = kindergarten_participation_rate_variation(district, against)
      hs = high_school_graduation_rate_variation(district, against)
      (kg/hs).to_s[0..4].to_f
    end

    def kindergarten_participation_correlates_with_high_school_graduation(district)
      if district[:for] == "STATEWIDE"
        statewide_correlation(district)
      elsif district[:across]
        multiple_district_correlation(district)
      else
        single_district_correlation(district)
      end
    end

    def single_district_correlation(district)
      sdc = kindergarten_participation_against_high_school_graduation(district[:for])
      check_variance(sdc)
    end

    def multiple_district_correlation(districts)
      results = districts[:across].map do |district|
        check_variance(kindergarten_participation_against_high_school_graduation(district))
      end
      (results.count(true) / (results.count)) > 0.70
    end

    def statewide_correlation(district)
      results = @distrepo.districts.keys.map do |district_name|
        check_variance(kindergarten_participation_against_high_school_graduation(district_name))
      end
      (results.count(true) / (results.count)) > 0.70
    end

    def check_variance(value)
     value >= 0.6 && value <= 1.5
    end
end
