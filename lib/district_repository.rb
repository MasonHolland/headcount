require 'csv'

class DistrictRepository

  def initialize
    @districts = {}
  end

  def load_data(path)
    filename = path[:enrollment][:kindergarten]
    contents =CSV.open(filename, headers: true, header_converters: :symbol)
    contents.each do |row|
      name = row[:Location]
    end
    # CSV.open "enrollemnt hash path", headers: true header_converters: :symbol
  end

  def find_by_name(name)
  end

end
