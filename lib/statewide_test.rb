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

  end
