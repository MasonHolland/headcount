require '.test/test_helper'
require './lib/enrollment'

class TestEnrollment < Mintest::Test

  def test_it_exists
    e = Enrollment.new{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_instance_of Enrollment, e
  end
end
