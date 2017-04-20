require_relative 'district_repository'


class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(dist_1, dist_2)
    (district_average(dist_1)/district_average(dist_2[:against])).round(3)
  end

  def district_average(district)
    total_dist_attendance(district).round(3)
  end

  def total_dist_attendance(district)
    count = 0
    find_district(district).reduce(0) do |total, (key, value)|
      count += 1
      total += value
      total
    end/count
  end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    district_2 = district_2[:against]
    first = find_district(district_1)
    second = find_district(district_2)
    result = first.reduce({}) do |hash, (key, value)|
      hash[key] = (first[key]/second[key]).round(3)
      hash
    end
    result = Hash[result.sort]
  end

  def find_district(district)
    dr.find_by_name(district).enrollment.kindergarten_participation_by_year
  end

end
