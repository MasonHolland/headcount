require_relative "test_helper"

class TestEnrollment < Minitest::Test

  def test_it_exists
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_instance_of Enrollment, e
  end

  def test_kindergarten_participation_by_year
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_equal e.kindergarten_participation_by_year, {2010=>0.391, 2011=>0.353, 2012=>0.267}
  end

  def test_kindergarten_participation_in_year
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_equal 0.391, e.kindergarten_participation_in_year(2010)
  end

end
