require_relative "test_helper"
require 'pry'

class TestHeadcountAnalyst < Minitest::Test
  def test_headcount_analyst_exists
    ha = HeadcountAnalyst.new(DistrictRepository.new)
    
    assert_instance_of HeadcountAnalyst, ha
  end
end