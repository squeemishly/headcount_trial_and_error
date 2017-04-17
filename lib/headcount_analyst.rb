require_relative 'district_repository'


class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    ave = district_average(district_1)/district_average(district_2[:against])
    ave.round(3)
  end

  def district_average(district)
    count = 0
    total = 0
    stats = dr.find_by_name(district).enrollment.kindergarten_participation_by_year
    stats.each do |key, value|
      count += 1
      total = total + value
    end
    average = (total/count).round(3)
  end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    district_2 = district_2[:against]
    first = dr.find_by_name(district_1).enrollment.kindergarten_participation_by_year
    second = dr.find_by_name(district_2).enrollment.kindergarten_participation_by_year
    result = {}
    first.each do |key, value|
      result[key] = (first[key]/second[key]).round(3)
    end
    result = Hash[result.sort]
  end
end
