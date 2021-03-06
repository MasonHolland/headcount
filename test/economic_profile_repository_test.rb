require_relative "test_helper"

class TestEconomicProfileRepository < Minitest::Test
  
  def test_object_is_an_economic_profile_repo
    er = EconomicProfileRepository.new 

    assert_instance_of EconomicProfileRepository, er
  end

  def test_repo_can_populate_economic_profiles
    er = EconomicProfileRepository.new 
    er.load_data({:economic_profile => {
      :median_household_income => "./data/Median household income.csv",
      :children_in_poverty => "./data/School-aged children in poverty.csv",
      :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
      :title_i => "./data/Title I students.csv"
      }})
    
    eco_profile = er.find_by_name("ACADEMY 20")
    assert_instance_of EconomicProfile, eco_profile
  end

  def test_repo_can_find_by_name
    er = EconomicProfileRepository.new 
    er.load_data({:economic_profile => {
      :median_household_income => "./data/Median household income.csv",
      :children_in_poverty => "./data/School-aged children in poverty.csv",
      :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
      :title_i => "./data/Title I students.csv"
      }})
    
    eco_profile = er.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", eco_profile.name    
  end

  def test_enrollments_stored_in_hash
    er = EconomicProfileRepository.new
    er.load_data({:economic_profile => {
      :median_household_income => "./data/Median household income.csv",
      :children_in_poverty => "./data/School-aged children in poverty.csv",
      :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
      :title_i => "./data/Title I students.csv"
      }})
    assert_equal Hash, er.economic_profiles.class
    assert_equal 181, er.economic_profiles.count
  end
  
  def test_ep_data_framework
    er = EconomicProfileRepository.new
    assert_equal Hash, er.ep_data_framework("Academy 20").class
  end

end
