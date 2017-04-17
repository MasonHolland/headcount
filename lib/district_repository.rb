require 'csv'
require_relative 'district'
require_relative 'enrollment_repository'

class DistrictRepository
  attr_accessor :contents, :districts, :name, :enrollment_repository

    def initialize
      @districts = {}
      @enrollment_repository = EnrollmentRepository.new
    end

    def load_data(path)
      enrollment_repository.load_data(path)
      CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
        name = row[:location]
        district = District.new({:name => name, :repo => self})
        @districts[district.name] = district unless @districts.has_key?(name)
      end

    end

    def find_by_name(region)
      @districts[region.upcase] if @districts.has_key?(region.upcase)
    end

    def find_all_matching(string)
      if @districts != []
        found = @districts.select {|dis| dis.name.include?(string.upcase)}
        found.map { |district| district.name }
      else
        []
      end
    end
end
