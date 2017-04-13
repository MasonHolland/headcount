require 'csv'
require_relative 'enrollment'
require 'bigdecimal'
require 'pry'

class EnrollmentRepository
  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      years = row[:timeframe]
      enrollment = Enrollment.new({:name => name, :kindergarten_participation => :years})
      @enrollments << enrollment if @enrollments.none? { |existing| existing.name == enrollment.name }
    end
  end

  def find_by_name(name)
    @enrollments.find {|enrlmnt| enrlmnt.name == name.upcase}
  end
  #
  # def kindergarten_participation
  #   @enrollments[years]
  # end

end
