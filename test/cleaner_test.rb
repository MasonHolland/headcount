require_relative "test_helper"

class TestCleaner < Minitest::Test
  def test_object_is_a_clean
    cleaner = Cleaner.new
    
    assert_instance_of Cleaner, cleaner
  end

  def test_can_truncate
    clean = Cleaner.new

    assert_equal 0.108, Cleaner.truncate(0.1083519)
  end

  def test_grade_return
    assert_equal :third_grade, Cleaner.grade(3)
    assert_equal :eighth_grade, Cleaner.grade(8)
    assert_equal :eighth_grade, Cleaner.grade(:eighth_grade)
  end
end