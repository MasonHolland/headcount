require 'csv'
require_relative 'enrollment'
require 'bigdecimal'
require 'pry'

class EnrollmentRepository
  def initialize(enrollments = {})
    @enrollments = enrollments
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      years = row[:timeframe]
      enrollment = Enrollment.new({:name => name})
      @enrollments[enrollment.name] = enrollment unless @enrollments.has_key?(name)
    end
  end

  def find_by_name(name)
    @enrollments[name.upcase]
  end

  # def kindy_part_storage
  #   @enrollments[name].kindergarten_participation
  # end

  def kindergarten_participation
    @enrollments[years]
  end

end
