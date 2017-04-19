require "csv"

class EconomicProfileRepository
  
  def initialize
    @economic_profiles = {}
    @row_object = ""
  end

  def load_data(path)
    path[:economic_profile].each do |symbol, filepath|
      CSV.foreach(filepath, headers: true, header_converters: symbol) do |row|
        @row_object = row
        populate_eco_repo(row, symbol)
      end
    end
  end

  def find_by_name(name)
    @economic_profiles[name]
  end

end
