require 'csv'
require_relative 'enrollment'
require 'pry'

class EnrollmentRepository
  attr_reader :enrollments
  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      year = row[:timeframe].to_i
      enro = Enrollment.new(enrollment_data_framework(name, year, row))
       if @enrollments == []
        @enrollments << enro
       elsif @enrollments.none? { |existing| existing.name == enro.name }
        @enrollments << enro
       else
        find_enro = @enrollments.find { |existing| existing.name == enro.name }
        find_enro.kindergarten_participation = find_enro.kindergarten_participation.merge(enro.kindergarten_participation)

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
