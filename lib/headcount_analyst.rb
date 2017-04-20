require_relative 'district_repository'


class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(dist_1, dist_2)
    (district_average(dist_1)/district_average(dist_2[:against])).round(3)
  end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    first = find_district(district_1)
    second = find_district(district_2[:against])
    result = first.reduce({}) do |hash, (key, value)|
      hash[key] = (first[key]/second[key]).round(3)
      hash
    end
    result = Hash[result.sort]
  end

  def kindergarten_participation_against_high_school_graduation(district)
    (kindergarten_variation(district)/graduation_variation(district)).round(3)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(dist)
    dist = dist[:for]
    if dist == 'STATEWIDE'
      num = statewide
    else
      num = kindergarten_participation_against_high_school_graduation(dist)
    end
    num > 0.6 && num < 1.5
  end

  def graduation_variation(district_1, district_2 = 'COLORADO')
    first = find_district_graduation(district_1)
    second = find_district_graduation(district_2)
    determine_variation(first, second)
  end

  def kindergarten_variation(district_1, district_2 = 'COLORADO')
    first = find_district(district_1)
    second = find_district(district_2)
    determine_variation(first, second)
  end

  def statewide
    #everything about this is hideous. but it's almost midnight and I'm dying
    k_total = 0
    hs_total = 0
    dr.enrollment_repo.enrollments.each do |enrollment|
      k_total += find_the_ave(find_district(enrollment.name))
      hs_total = find_the_ave(find_district_graduation(enrollment.name))
    end
    k_total/hs_total
  end

  def determine_variation(first, second)
    (find_the_ave(first)/find_the_ave(second)).round(3)
  end

  def find_district(district)
    dr.find_by_name(district).enrollment.kindergarten_participation_by_year
  end

  def find_district_graduation(district)
    dr.find_by_name(district).enrollment.school_info[:high_school_graduation]
  end

  def find_the_ave(district)
    counter = 0
    district.reduce(0) do | total, (key, value) |
      counter += 1
      total + value
    end/counter
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


end
