class Enrollment
  attr_reader :school_info,
              :name

  def initialize(school_info)
    @name = school_info[:name].upcase
    # @kindergarten_participation = school_info[:kindergarten_participation]
    # @high_school_graduation = school_info[:high_school_graduation]
    @school_info = school_info
    # @type = school_info[:type]
    # @data = school_info[:kindergarten_participation]
    # @dataformat = school_info[:school_participation][:dataformat]
    # @data = school_info[:kindergarten_participation][:data]
    # @parent = parent
  end

#### need to truncate to the 3rd digit... do this. or die###
  def kindergarten_participation_by_year
    numberize_values(kindergarten)
  end

  def kindergarten_participation_in_year(year)
    numberize_values(kindergarten)[year]
  end

  def graduation_rate_by_year
    numberize_values(high_school)
  end

  def graduation_rate_in_year(year)
    numberize_values(high_school)[year]
  end

  def numberize_values(data)
    # binding.pry
    Hash[data.keys.map(&:to_i).zip(data.values.map {|x| x.to_f.round(3)})]
  end

  def kindergarten
    school_info[:kindergarten_participation] || school_info[:kindergarten]
  end

  def high_school
    school_info[:high_school_graduation]
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
