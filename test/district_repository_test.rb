require_relative "test_helper"


class TestDistrictRepository < Minitest::Test

  def test_district_repo_exists
    dr = DistrictRepository.new
    assert_instance_of DistrictRepository, dr
  end

  def test_district_repo_can_find_one_district_by_name
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_by_name("Adams County 14")
    assert_equal "ADAMS COUNTY 14", district.name
    assert_instance_of District, district
  end

  def test_district_repo_can_find_by_matching
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_all_matching("Adams")
    assert_equal ["ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J"], district
  end
end
