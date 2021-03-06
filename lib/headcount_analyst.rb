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
    if dist.keys == [:for]
      dist = dist[:for]
      if dist == 'STATEWIDE'
          statewide
      else
        num = kindergarten_participation_against_high_school_graduation(dist)
        num > 0.6 && num < 1.5
      end
    elsif dist.keys == [:across]
      across_districts(dist) > 0.6 && across_districts(dist) < 1.5
    end
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
    correlation = dr.enrollment_repo.enrollments.count do |enrollment|
      kindergarten_participation_correlates_with_high_school_graduation({for: enrollment.name})
    end
    percent = correlation/dr.enrollment_repo.enrollments.count
    percent >= 0.70
  end

  def across_districts(dist)
    dists = dist[:across]
    dists.reduce(0) do |total, dist|
      total + kindergarten_participation_against_high_school_graduation(dist)
    end/(dists.count)
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
    end/count
  end


end
