require './test/test_helper'
require './lib/enrollment_repository'

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
end
