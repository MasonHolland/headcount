require_relative "test_helper"
require 'pry'

class TestHeadcountAnalyst < Minitest::Test

  def disrepo
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv", :high_school_graduation => "./data/High school graduation rates.csv"}})
    dr
  end

  def test_headcount_analyst_exists
    ha = HeadcountAnalyst.new(disrepo)

    assert_instance_of HeadcountAnalyst, ha
  end

  def test_headcount_analyst_initialized_with_dr
    ha = HeadcountAnalyst.new(disrepo)

    assert [], ha.distrepo.districts
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

    assert_equal ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO'), {2004 => 1.258, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.687, 2013 => 0.693, 2014 => 0.661 }
  end

  def test_kindy_participation_against_high_school_graduation
    ha = HeadcountAnalyst.new(disrepo)

    assert_equal 0.641, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    ha = HeadcountAnalyst.new(disrepo)

    ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')

    assert ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_for_multipled_districts
    ha = HeadcountAnalyst.new(disrepo)
    coefficient = ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ACADEMY 20", "ADAMS COUNTY 14", "AGATE 300"])

    refute coefficient
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_statewide
    ha = HeadcountAnalyst.new(disrepo)
    coefficient = ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "STATEWIDE")

    refute coefficient
  end

  def test_check_variance
    ha = HeadcountAnalyst.new(disrepo)
    x = 0.5
    y = 1.1

    refute ha.check_variance(x)
    assert ha.check_variance(y)
  end
end
