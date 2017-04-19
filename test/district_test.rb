require_relative "test_helper"

class TestDistrict < Minitest::Test

  def test_the_object_is_a_district
    d = District.new({:name => "ACADEMY 20"})

    assert_instance_of District, d
  end

  def test_district_has_a_name
    d = District.new({:name => "ACADEMY 20"})

    assert_equal "ACADEMY 20", d.name
  end
end
