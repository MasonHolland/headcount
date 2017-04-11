require 'minitest/pride'
require 'minitest/autorun'
require "./lib/district_repository"
require "./lib/district"

class DistrictRepositoryTest < Minitest::Test

  def test_district_repo_exists
    dr = DistrictRepository.new
    assert_instance_of DistrictRepository, dr
  end

  def test_district_repo_can_find_one_district_by_name
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"}})
    # binding.pry
    district = dr.find_by_name("Adams County 14")
    assert_equal "ADAMS COUNTY 14", district.name
    # assert_instance_of District, district
  end

end
