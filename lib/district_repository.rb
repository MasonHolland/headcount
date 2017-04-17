require 'csv'
require_relative 'district'
require_relative 'enrollment_repository'

class DistrictRepository
  attr_accessor :contents, :districts, :name, :enrollment_repository

    def initialize(districts = {})
      @districts = districts
      @enrollment_repository = EnrollmentRepository.new
    end

    def load_data(path)
      enrollment_repository.load_data(path)
      CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
        name = row[:location].upcase
        district = District.new({:name => name, :repo => self})
        @districts << district if @districts.none? { |existing| existing.name == district.name }
      end

    end

    def find_by_name(region)
      @districts.find {|dis| dis.name == region.upcase}
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
