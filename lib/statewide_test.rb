class StateWideTest
  attr_reader :name, :grade_year_subject, :race_year_subject, :error

    def initialize(input = {})
      @name = input[:name]
      @grade_year_subject = input[:grade_year_subject] if grade_key(input)
      @race_year_subject = input[:grade_year_subject] if race_key(input)
    end

    def grade_key(input)
      input.has_key?(:grade_year_subject)
    end

    def race_key(input)
      input.has_key?(:race_year_subject)
    end

    def proficient_by_grade(grade)
      cleaned_grade = grade.to_s[0..4].to_f
      raise UnknownDataError unless @grade_year_subject[cleaned_grade]
        race_year_subject[cleaned_grade]
    end

    def proficient_by_race_or_ethnicity(race)
      raise UnknownDataError unless @race_year_subject[race]
        @race_year_subject[race]
    end

    def proficient_for_subject_by_grade_in_year(subject, grade, year)
      raise UnknownDataError unless check_grade_keys(grade, year, subject)
        @grade_year_subject[grade.to_s[0..4].to_f][year][subject]
    end

    def proficient_for_subject_by_race_in_year(subject, race, year)
      raise UnknownDataError unless check_race_keys(race, year, subject)
        @race_year_subject[race][year][subject]
    end

    def check_grade_keys(grade, year, subject)
      gys = @grade_year_subject
      (gys[grade.to_s[0..4].to_f] && gys[grade.to_s[0..4].to_f][year] && gys[grade.to_s[0..4].to_f][year][subject])
    end

    def check_race_keys(race, year, subject)
      rys = @race_year_subject
      (rys[race] && rys[race][year] && rys[race][year][subject])
    end
  end
