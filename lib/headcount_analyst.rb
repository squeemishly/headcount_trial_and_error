require_relative 'district_repository'


class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    binding.pry

  end

  def district_average(district)
    count, total = 0
    stats = dr.find_by_name(district).enrollment.kindergarten_participation_by_year
    stats.each do |key, value|
      count += 1
      total = total + value
    end
    average = (total/count).round(3)
  end
end
