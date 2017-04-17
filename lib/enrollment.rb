class Enrollment
  attr_reader :school_info,
              :name

  def initialize(school_info)
    @name = school_info[:name].upcase
    @kindergarten_participation = school_info[:kindergarten_participation]
    @school_info = school_info
    # @data = school_info[:kindergarten_participation]
    # @dataformat = school_info[:school_participation][:dataformat]
    # @data = school_info[:kindergarten_participation][:data]
    # @parent = parent
  end

#### need to truncate to the 3rd digit... do this. or die###
  def kindergarten_participation_by_year
    numberize_values
  end

  def kindergarten_participation_in_year(year)
    numberize_values[year].round(3)
  end

  def numberize_values
    numberized = Hash[@kindergarten_participation.keys.map(&:to_i)
      .zip(@kindergarten_participation.values.map(&:to_f))]
  end


  # def truncate_percentages(value)
  #   value.round(3)
  # end
end
# ---------------------------------------------------------------------------
# require 'pry'
#
# class Enrollment
#   attr_reader :name,
#               :timeframe,
#               :dataformat,
#               :data,
#               :parent
#
#   def initialize(row, parent = nil)
#     @name = row[:location].upcase
#     @timeframe = row[:timeframe].to_i
#     @dataformat = row[:dataformat]
#     @data = row[:data]
#     @parent = parent
#       # binding.pry
#   end
# end
