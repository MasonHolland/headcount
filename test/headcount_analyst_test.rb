require_relative "test_helper"
require 'pry'

class TestHeadcountAnalyst < Minitest::Test

  def disrepo
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    dr
  end

  def test_headcount_analyst_exists
    ha = HeadcountAnalyst.new(disrepo)

    assert_instance_of HeadcountAnalyst, ha
  end

  def test_headcount_analyst_initialized_with_dr
    ha = HeadcountAnalyst.new(disrepo)

    assert [], ha.district_repository.districts
  end

  def test_headcount_analyst_calculates_variation
    ha = HeadcountAnalyst.new(disrepo)

    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_headcount_analyst_calculates_variation_with_other_district
    ha = HeadcountAnalyst.new(disrepo)

    assert_equal 0.446, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_headcount_analyst_calculates_trend_of_all_years
    ha = HeadcountAnalyst.new(disrepo)

    assert_equal ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO'), {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
  end
end
