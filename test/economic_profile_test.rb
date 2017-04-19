require_relative "test_helper"

class TestEconomicProfile < Minitest::Test
  
  def data
    {
      name: "name",
      median_household_income: {[2006, 2010]=>85450, [2008, 2012]=>89615, [2007, 2011]=>88099, [2009, 2013]=>89953},
      children_in_poverty:
        {
          1995=>0.032,
          1997=>0.035,
          1999=>0.032,
          2000=>0.031
        },
      free_or_reduced_price_lunch:
      {
        2014=>{:total=>3132, :percentage=>0.127},
        2004=>{:total=>1182, :percentage=>0.06},
        2003=>{:percentage=>0.06, :total=>1062},
        2002=>{:total=>905, :percentage=>0.048},
        2001=>{:percentage=>0.047, :total=>855},
        2000=>{:total=>701, :percentage=>0.04}
       },
      title_i: {2009=>0.014, 2011=>0.011, 2012=>0.0107, 2013=>0.0125, 2014=>0.027}
    }
  end
  
  def test_object_is_eco_profile
    ep = EconomicProfile.new(data)

    assert_instance_of EconomicProfile, ep
  end
end