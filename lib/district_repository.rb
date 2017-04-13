require 'csv'
require_relative 'district'
require 'pry'

class DistrictRepository
  attr_accessor :contents, :districts, :name

  def initialize(districts = [])
    @districts = districts
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      district = District.new({:name => name})
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
