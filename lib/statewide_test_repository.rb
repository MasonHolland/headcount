require 'csv'
require_relative 'statewide_test'
require_relative 'cleaner'

class StatewideTestRepository
  attr_reader :subject, :top_key, :root
    def initialize
      @statewide_tests = {}
    end

    def load_data(path)
      path[:statewide_testing].each do |symbol, file_path|
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
          name = row[:location].upcase
          year = row[:timeframe].to_i
          race = row[:race_ethnicity]
          score = row[:score]
          symbol_picker(symbol, score, race)
          make_statewide_test(name, year, top_key, subject, row)
        end
      end
    end

    def symbol_picker(symbol, score, race)
      if symbol == :third_grade || symbol == :eighth_grade
        if symbol == :third_grade
          @top_key = symbol
        elsif symbol == :eighth_grade
          @top_key = symbol
        end
        @subject = score.downcase.to_sym
      else
        @top_key = race.downcase.to_sym
        @subject = symbol.downcase.to_sym
      end
    end

    def make_statewide_test(name, year, top_key, subject, row)
      unless @statewide_tests.has_key?(name)
        @statewide_tests[name] = StatewideTest.new({:name => name,
          :grade_year_subject => {},
          :race_year_subject => {}})
        end
        statewide_test = @statewide_tests[name]
        top_key_checker(top_key, statewide_test, year)
        root_checker(root, top_key, year, subject, row)
    end
  


    def find_by_name(name)
      @statewide_tests[name.upcase] if name
    end

    def top_key_checker(top_key, statewide_test, year)
      if top_key == :third_grade || top_key == :eighth_grade
        @root = statewide_test.grade_year_subject
      else
        @root = statewide_test.race_year_subject
      end
    end

    def root_checker(root, top_key, year, subject, row)
      root[top_key] = {} unless root.has_key?(top_key)
      root[top_key][year] = {} unless root[top_key].has_key?(year)
      root[top_key][year][subject] = Cleaner.data(row)
    end
end
