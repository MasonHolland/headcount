require 'csv'
require_relative 'district'
require 'pry'

class DistrictRepository
  attr_accessor :data , :name
  attr_accessor :districts
  
  def initialize
    @districts = []
  end


  # def load_data(path)
    # filename = path[:enrollment][:kindergarten]
    # CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    #   name = row[:location].upcase
    #   dis = District.new(:name => name.upcase)
    #   @districts[dis.name] = dis
      # end
  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    # data.each do |row|
    #   name = row[:Location]
    # end
    # binding.pry
  end

  def find_by_name(name)
    data.each do |row|
      if row[:location] == name.upcase
        districts = District.new(row)
      end
      # binding.pry
    end
  end

end

# binding.pry
""