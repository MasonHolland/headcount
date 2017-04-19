require_relative 'test_helper'
require_relative '../lib/statewide_test'
require_relative '../lib/statewide_test_repository'

  class StatewideTestTest < Minitest::Test

    def data
      {name: "COLORADO",
       grade_year_subject: {:third_grade=>{2008=>{:math=>0.697}}},
       race_year_subject: {:all_students=>{2011=>{:math=>0.557}}},
       asian: {2011=>{:math=>0.709}}}
    end

    def test_it_exists
      st = StatewideTest.new
      assert_instance_of StatewideTest, st
    end

    def test_statewide_test_has_name
      st = StatewideTest.new(data)
      assert_equal "COLORADO", st.name
      assert_equal String, st.name.class
    end

    def test_statewide_test_has_grade_data
      st = StatewideTest.new(data)
      actual = ({:third_grade=>{2008=>{:math=>0.697}}})
      assert_equal actual, st.grade_year_subject
      assert_equal Hash, st.grade_year_subject.class
    end



end
