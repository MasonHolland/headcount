require 'csv'
require_relative 'district'
require_relative 'enrollment_repository'

class DistrictRepository
  attr_accessor :districts, :enrollment_repository

    def initialize
      @districts = {}
      @enrollment_repository = EnrollmentRepository.new
    end

    def load_data(path)
      enrollment_repository.load_data(path)
      CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
        name = row[:location]
        district = District.new({:name => name.upcase}, self)
        @districts[district.name] = district unless @districts.has_key?(name)
      end

    end

    def find_by_name(region)
      @districts[region.upcase] if @districts.has_key?(region.upcase)
    end

    def find_enrollment(name)
      @enrollment_repository.find_by_name(name)
    end

    def find_all_matching(name_fragment)
      found_districts = []
      if name_fragment.empty? || name_fragment.nil?
      else
        @enrollment_repository.enrollments.keys.each { |v| found_districts << v if v.start_with?(name_fragment.upcase)}
      end
     found_districts
    end
end
