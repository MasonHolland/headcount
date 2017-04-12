require_relative '../lib/district'
require './test/test_helper'

class TestDistrict < Minitest::Test

  def test_the_object_is_a_district
    d = District.new({:name => "ACADEMY 20"})
    assert_instance_of District, d
  end
end
