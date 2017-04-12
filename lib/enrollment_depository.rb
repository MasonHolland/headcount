require 'csv'
require_relative 'enrollment'
require 'pry'

class EnrollmentDepository
  def initialize
    @enrollments = {}
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      enrollments = Enrollment.new({:name => name}, self)
      @enrollments[district.name] = enrollment unless @enrollments.has_key?(name)
    end
  end

  def find_by_name(name)
    @enrollments[name.upcase]
  end

end 