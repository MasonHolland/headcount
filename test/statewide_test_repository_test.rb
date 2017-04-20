require_relative 'test_helper'

class StatewideTestRepositoryTest < Minitest::Test

  def test_statewide_test_repo_exists
    statewide = StatewideTestRepository.new
    assert_instance_of StatewideTestRepository, statewide
  end

  def test_statewide_test_repo_find_name
    statewide_repo = StatewideTestRepository.new
    statewide_repo.load_data({:statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

    st = statewide_repo.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", st.name
  end

  def test_statewide_test_repo_proficient_by_grade
    statewide_repo = StatewideTestRepository.new
    statewide_repo.load_data({
      :statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

    st = statewide_repo.find_by_name("ACADEMY 20")
    year_hash = st.proficient_by_grade(:eighth_grade)

    assert_equal 7, year_hash.keys.length
    assert_equal true, year_hash.has_key?(2008)


    subject_hash = year_hash[2008]
    assert_equal 3, subject_hash.keys.length
    assert_equal true, subject_hash.has_key?(:math)
    assert_equal true, subject_hash.has_key?(:reading)
    assert_equal true, subject_hash.has_key?(:writing)
    assert_equal 0.64, subject_hash[:math]
    assert_equal 0.843, subject_hash[:reading]
    assert_equal 0.734, subject_hash[:writing]
  end

  def test_statewide_test_repo_proficient_by_race
    statewide_repo = StatewideTestRepository.new
    statewide_repo.load_data({
      :statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

    st = statewide_repo.find_by_name("ACADEMY 20")
    year_hash = st.proficient_by_race_or_ethnicity(:asian)

    assert_equal 4, year_hash.keys.length
    assert_equal true, year_hash.has_key?(2011)

    subject_hash = year_hash[2011]
    assert_equal 3, subject_hash.keys.length
    assert_equal true, subject_hash.has_key?(:math)
    assert_equal true, subject_hash.has_key?(:reading)
    assert_equal true, subject_hash.has_key?(:writing)
    assert_in_delta 0.816, subject_hash[:math], 0.005
    assert_in_delta 0.897, subject_hash[:reading], 0.005
    assert_in_delta 0.826, subject_hash[:writing], 0.005
    end

    def test_statewide_test_repo_proficient_for_subject_by_grade_in_year

  statewide_repo = StatewideTestRepository.new
  statewide_repo.load_data({
    :statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

  st = statewide_repo.find_by_name("ACADEMY 20")
  proficiency = st.proficient_for_subject_by_grade_in_year(:math, :third_grade, 2009)

  assert_equal 0.824, proficiency
  end


  def test_statewide_test_repo_proficient_for_subject_by_race_in_year
    statewide_repo = StatewideTestRepository.new
    statewide_repo.load_data({
      :statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

    st = statewide_repo.find_by_name("ACADEMY 20")
    proficiency = st.proficient_for_subject_by_race_in_year(:math, :asian, 2011)
    assert_in_delta 0.816, proficiency, 0.005
  end


  def statewide_repo
    str = StatewideTestRepository.new
    str.load_data({:statewide_testing => {
                      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})
    str
  end

  def district_repo
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                   },
                   :statewide_testing => {
                     :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                     :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                     :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                   }
                 })
    dr
  end

  def test_statewide_testing_repository_basics
    str = statewide_repo
    assert str.find_by_name("ACADEMY 20")
    assert str.find_by_name("GUNNISON WATERSHED RE1J")
  end

  def test_basic_proficiency_by_grade
    str = statewide_repo
    expected = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
                 2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
                 2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
                 2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
                 2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
                 2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
                 2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
               }

    testing = str.find_by_name("ACADEMY 20")
    expected.each do |year, data|
      data.each do |subject, proficiency|
        assert_in_delta proficiency, testing.proficient_by_grade(3)[year][subject], 0.005
      end
    end
  end

  def test_basic_proficiency_by_race
    str = statewide_repo
    testing = str.find_by_name("ACADEMY 20")
    expected = { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
                 2012 => {math: 0.818, reading: 0.893, writing: 0.808},
                 2013 => {math: 0.805, reading: 0.901, writing: 0.810},
                 2014 => {math: 0.800, reading: 0.855, writing: 0.789},
               }
    result = testing.proficient_by_race_or_ethnicity(:asian)
    expected.each do |year, data|
      data.each do |subject, proficiency|
        assert_in_delta proficiency, result[year][subject], 0.005
      end
    end

    expected = {2011=>{:math=>0.451, :reading=>0.688, :writing=>0.503},
                2012=>{:math=>0.467, :reading=>0.75, :writing=>0.528},
                2013=>{:math=>0.473, :reading=>0.738, :writing=>0.531},
                2014=>{:math=>0.418, :reading=>0.006, :writing=>0.453}}

    testing = str.find_by_name("WOODLAND PARK RE-2")

    result = testing.proficient_by_race_or_ethnicity(:hispanic)
    expected.each do |year, data|
      data.each do |subject, proficiency|
        assert_in_delta proficiency, result[year][subject], 0.005
      end
    end

    expected = {2011=>{:math=>0.581, :reading=>0.792, :writing=>0.698},
                2012=>{:math=>0.452, :reading=>0.773, :writing=>0.622},
                2013=>{:math=>0.469, :reading=>0.714, :writing=>0.51},
                2014=>{:math=>0.468, :reading=>0.006, :writing=>0.488}}

    testing = str.find_by_name("PAWNEE RE-12")
    result = testing.proficient_by_race_or_ethnicity(:white)

    expected.each do |year, data|
      data.each do |subject, proficiency|
        assert_in_delta proficiency, result[year][subject], 0.005
      end
    end
  end

  def test_proficiency_by_subject_and_year
    str = statewide_repo

    testing = str.find_by_name("ACADEMY 20")
    assert_in_delta 0.653, testing.proficient_for_subject_by_grade_in_year(:math, 8, 2011), 0.005

    testing = str.find_by_name("WRAY SCHOOL DISTRICT RD-2")
    assert_in_delta 0.89, testing.proficient_for_subject_by_grade_in_year(:reading, 3, 2014), 0.005

    testing = str.find_by_name("PLATEAU VALLEY 50")
    assert_equal "N/A", testing.proficient_for_subject_by_grade_in_year(:reading, 8, 2011)
  end

  def test_proficiency_by_subject_race_and_year
    str = statewide_repo

    testing = str.find_by_name("AULT-HIGHLAND RE-9")
    assert_in_delta 0.611, testing.proficient_for_subject_by_race_in_year(:math, :white, 2012), 0.005
    assert_in_delta 0.310, testing.proficient_for_subject_by_race_in_year(:math, :hispanic, 2014), 0.005
    assert_in_delta 0.794, testing.proficient_for_subject_by_race_in_year(:reading, :white, 2013), 0.005
    assert_in_delta 0.278, testing.proficient_for_subject_by_race_in_year(:writing, :hispanic, 2014), 0.005

    testing = str.find_by_name("BUFFALO RE-4")
    assert_in_delta 0.65, testing.proficient_for_subject_by_race_in_year(:math, :white, 2012), 0.005
    assert_in_delta 0.437, testing.proficient_for_subject_by_race_in_year(:math, :hispanic, 2014), 0.005
    assert_in_delta 0.76, testing.proficient_for_subject_by_race_in_year(:reading, :white, 2013), 0.005
    assert_in_delta 0.375, testing.proficient_for_subject_by_race_in_year(:writing, :hispanic, 2014), 0.005
  end

  def test_unknown_data_errors
    str = statewide_repo
    testing = str.find_by_name("AULT-HIGHLAND RE-9")

    assert_raises(UnknownDataError) do
      testing.proficient_by_grade(1)
    end

    assert_raises(UnknownDataError) do
      testing.proficient_for_subject_by_grade_in_year(:pizza, 8, 2011)
    end

    assert_raises(UnknownDataError) do
      testing.proficient_for_subject_by_race_in_year(:reading, :pizza, 2013)
    end

    assert_raises(UnknownDataError) do
      testing.proficient_for_subject_by_race_in_year(:pizza, :white, 2013)
    end
  end
end
