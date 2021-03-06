require_relative "test_helper"

class TestEnrollmentRepository < Minitest::Test

  def test_enrollment_repo_exists
    er = EnrollmentRepository.new
    assert_instance_of EnrollmentRepository, er
  end

  def test_can_find_by_name
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", enrollment.name
  end

  def test_can_find_by_name_twice
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", enrollment.name
    enrollment = er.find_by_name("ADAMS COUNTY 14")

    assert_equal "ADAMS COUNTY 14", enrollment.name
  end

  def test_loading_and_finding_enrollment_by_a_different_name
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)

    assert_equal name, enrollment.name
  end

  def test_the_enrollment_is_an_enrollment
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)

    assert enrollment.is_a?(Enrollment)
  end

  def test_the_enrollment_will_meet_rake_spec
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)

    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end

  def test_the_enrorepo_can_load_and_find_hs_by_name
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv",
     :high_school_graduation => "./data/High school graduation rates.csv"}})

    enrollment = er.find_by_name("ACADEMY 20")
    
    assert_instance_of Enrollment, enrollment 
  end

  def test_the_enrorepo_can_find_hs_grad_rate_by_year  
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv",
     :high_school_graduation => "./data/High school graduation rates.csv"}})

    enrollment = er.find_by_name("ACADEMY 20")
    actual = enrollment.graduation_rate_by_year
    expect = { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
  
    assert_equal expect, actual
  end

  def test_graduation_rate_in_year

  end

end
