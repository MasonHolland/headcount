require_relative "test_helper"
require 'pry'

class TestHeadcountAnalyst < Minitest::Test

  def setup
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    dr
  end


  def test_headcount_analyst_exists
    ha = HeadcountAnalyst.new(setup)

    assert_instance_of HeadcountAnalyst, ha
  end

  def test_headcount_analyst_initialized_with_dr
    ha = HeadcountAnalyst.new(setup)

    assert [], ha.district_repository.districts
  end

  def test_headcount_analyst_calculates_variation
    ha = HeadcountAnalyst.new(setup)

    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

end
