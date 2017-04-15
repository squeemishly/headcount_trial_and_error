require 'pry'

class Enrollment
  attr_reader :school_info,
              :name

  def initialize(school_info)
    @name = school_info[:name].upcase
    @timeframe = school_info[:school_participation][:timeframe].to_i
    # @dataformat = school_info[:school_participation][:dataformat]
    @data = school_info[:school_participation][:data]
    # @parent = parent
    @school_info = school_info
  end

#### need to truncate to the 3rd digit... do this. or die###
  def kindergarten_participation_by_year
    @school_info[@school_info.keys[1]]
  end

  def kindergarten_participation_in_year(year)
    @school_info[@school_info.keys[1]][year]
  end
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
