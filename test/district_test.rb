gem 'minitest'
require_relative '../lib/district'
require 'minitest/pride'
require 'minitest/autorun'

class DistrictTest < Minitest::Test
  def test_the_object_is_a_district
    d = District.new
    

    assert_instance_of District, d
  end

end