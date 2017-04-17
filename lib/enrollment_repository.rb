require 'csv'
require_relative 'enrollment'
require 'pry'

class EnrollmentRepository
  attr_reader :enrollments
  def initialize(enrollments = {})
    @enrollments = enrollments
  end

  def load_data(path)
    path[:enrollment].each do |symbol, file_path|
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        name = row[:location]
        year = row[:timeframe].to_i
        if @enrollments[name] 
          @enrollments[name].kindergarten_participation[year] = row[:data]
        else
          enro = Enrollment.new({:name => name, :kindergarten_participation => {year => row[:data]}})
          @enrollments[name] = enro
        end
      end
    end
  end

  def find_by_name(name)
    @enrollments[name.upcase] if name
  end

  def enrollment_data_framework(name, year, row)
    { :name => name,
      :kindergarten_participation => {year => row[:data]}}
  end
end
