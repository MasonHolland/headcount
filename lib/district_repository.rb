require 'csv'
require_relative 'district'
require 'pry'

class DistrictRepository
  attr_accessor :contents, :districts, :name

  def initialize
    @districts = {}
  end

  def load_data(path)
    CSV.foreach(path[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      district = District.new({:name => name}, self)
      @districts[district.name] = district unless @districts.has_key?(name)
      # binding.pry
    end
  end

  def find_by_name(name)
    @districts[name.upcase]
  end

  def find_all_matching(name)
    inc = 0
    if districts == {}
      return []
    else
      [districts.include?(districts[name.upcase])]
      inc += 1
    end
    inc
  end


end
