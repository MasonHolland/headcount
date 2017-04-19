require_relative "test_helper"

class TestEconomicProfileRepository < Minitest::Test
  
  def test_object_is_an_economic_profile_repo
    er = EconomicProfileRepository.new 

    assert_instance_of EconomicProfileRepository, er
  end

  
end
