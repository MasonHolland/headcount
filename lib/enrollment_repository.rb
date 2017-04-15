require 'csv'
require_relative 'enrollment'

class EnrollmentRepository
  attr_reader :enrollments
  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      year = row[:timeframe].to_i
      enrollment = Enrollment.new(enrollment_data_framework(name, year, row))
       if @enrollments.none? { |existing| existing.name == enrollment.name }
        @enrollments << enrollment
      else
        d = Enrollment.new(enrollment_data_framework(name, year, row))
        @enrollments.name = d
        end
    end
  end

  def find_by_name(name)
    @enrollments.find {|enrlmnt| enrlmnt.name == name.upcase}
  end

  def enrollment_data_framework(name, year, row)
    { :name => name,
      :kindergarten_participation => {year => row[:data]}}
  end
end
