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
