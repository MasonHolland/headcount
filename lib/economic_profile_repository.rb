require "csv"
require_relative "economic_profile"
require_relative "cleaner"

class EconomicProfileRepository
  attr_reader   :economic_profiles, :row_object
  def initialize
    @economic_profiles = Hash.new(0)
    @row_object = nil
  end

  def load_data(path)
    path[:economic_profile].each do |symbol, file_path|
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @row_object = row
        populate_eco_repo(row, symbol)
      end
    end
  end

  def find_by_name(name)
    @economic_profiles[name]
  end

  def populate_eco_repo(row, symbol)
    # binding.pry
    eco_prof_key = @economic_profiles[Cleaner.input_name(row)]
    if eco_prof_key != 0
      eco_prof_populate(row, symbol, eco_prof_key)
    else
      create_new_ep(row)
    end
  end

  def eco_prof_populate(row, symbol, eco_prof_key)
    add_income(row, symbol, eco_prof_key) if median_symbol(symbol)
    add_poverty(row, eco_prof_key)        if poverty_symbol(symbol, row)
    add_lunch(row, eco_prof_key)          if lunch_symbol(symbol, row)
    add_title_i(row, eco_prof_key)        if title_i_symbol(symbol)
  end

  def create_new_ep(row)
    ep = EconomicProfile.new(ep_data_framework(Cleaner.input_name(row)))
    @economic_profiles[Cleaner.input_name(row)] = ep
  end

  def title_i_symbol(symbol)
    symbol == :title_i
  end

  def median_symbol(symbol)
    symbol == :median_household_income
  end

  def poverty_symbol(symbol, row)
    symbol == :children_in_poverty && Cleaner.pov_year(row) != nil
  end

  def lunch_symbol(symbol, row)
    Cleaner.poverty_level(row) == "Eligible for Free or Reduced Lunch"
  end

  def add_income(row, symbol, eco_prof_key)
    # binding.pry
    eco_prof_key.median_household_income[Cleaner.year(row, symbol)] = Cleaner.data(row)
  end
  
  def add_poverty(row, eco_prof_key)
    eco_prof_key.children_in_poverty[Cleaner.pov_year(row)]= Cleaner.pov_data(row)
  end

  def add_lunch(row, eco_prof_key)
    lunch_set = eco_prof_key.free_or_reduced_price_lunch
    lunch_set[Cleaner.year(row)][(Cleaner.dataformat(row))] = Cleaner.lunch_data(row)
  end

  def add_title_i(row, eco_prof_key)
    eco_prof_key.title_i[Cleaner.year(row)] = Cleaner.data(row)
  end
  
  def ep_data_framework(name)
    {
      :name => name,
      :median_household_income => Hash.new,
      :children_in_poverty => Hash.new,
      :free_or_reduced_price_lunch => Hash.new { |hash, key| hash[key] = {} },
      :title_i => Hash.new
    }
  end

end
