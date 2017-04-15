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
    def test_the_enrollment_is_array
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
end
