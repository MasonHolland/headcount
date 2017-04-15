require_relative "test_helper"
require 'pry'

class TestHeadcountAnalyst < Minitest::Test
  def test_headcount_analyst_exists
    ha = HeadcountAnalyst.new(DistrictRepository.new)
    
    assert_instance_of HeadcountAnalyst, ha
  end

  def test_headcount_analyst_initialized_with_dr
    ha = HeadcountAnalyst.new(DistrictRepository.new)

    assert [], ha.district_repository
  end


end