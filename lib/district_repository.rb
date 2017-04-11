require 'csv'
require_relative 'district'
require 'pry'

class DistrictRepository
  attr_reader :data
  attr_accessor :districts
  
  def initialize
    @districts = [] 
  end

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    # contents.foreach do |row|
    #   name = row[:Location]
    # end
    # CSV.open "enrollemnt hash path", headers: true header_converters: :symbol
  end

  def find_by_name(name)
    data.each do |row|
      if row[:location] == name.upcase
        districts = District.new(name)
      end
      # binding.pry
    end
  end

end
