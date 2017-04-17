require_relative "test_helper"
require 'pry'


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
    skip
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_all_matching("Adams")
    assert_equal ["ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J"], district
  end

  def test_find_by_name_will_automatically_create_enro_repo
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end

  def test_district_enrollment_relationship_basics
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    district = dr.find_by_name("GUNNISON WATERSHED RE1J")

    assert_in_delta 0.144, district.enrollment.kindergarten_participation_in_year(2004), 0.005
  end

  def test_enrollment_analysis_basics
    skip
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    ha = HeadcountAnalyst.new(dr)

    assert_in_delta 1.126, ha.kindergarten_participation_rate_variation("GUNNISON WATERSHED RE1J", :against => "TELLURIDE R-1"), 0.005
    assert_in_delta 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1'), 0.005
  end
end
