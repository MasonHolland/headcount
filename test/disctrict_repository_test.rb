require 'minitest/pride'
require 'minitest/autorun'
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/district"

class DistrictRepositoryTest < Minitest::Test

  def test_district_repo_exists
    dr = DistrictRepository.new
    assert_instance_of DistrictRepository, dr
  end


end
