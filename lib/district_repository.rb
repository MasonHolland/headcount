require 'csv'
require_relative 'district'
require 'pry'

class DistrictRepository
  attr_accessor :contents, :districts, :name

  def initialize
    @districts = {}
  end


  def load_data(path)
    filename = path[:enrollment][:kindergarten]
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      dis = District.new({:name => name.upcase}, self)
      @districts[dis.name] = dis unless @districts.has_key?(name)
      end
  end

  def find_by_name(name)
    @districts[name.upcase]
    end

binding.pry
end

# binding.pry
""
