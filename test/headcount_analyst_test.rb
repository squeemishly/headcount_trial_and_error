require_relative 'test_helper'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr,
              :ha

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({:enrollment =>
      {:kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"}})
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_it_exists
    assert_instance_of HeadcountAnalyst, ha
  end

  def test_it_has_access_to_the_district_repository
    assert_instance_of DistrictRepository, dr
    assert_instance_of District, dr.find_by_name("ACADEMY 20")
  end

  def test_it_can_find_kindergarten_stats
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 0.302, district.enrollment.kindergarten_participation_in_year(2004)
  end

  def test_it_can_find_a_districts_average_participation
    assert_equal 0.598, ha.district_average("ACADEMY 20")
  end

  def test_it_compares_a_districts_average_participation_against_another_district
    assert_equal 1.072, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.697, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_it_compares_a_districts_participation_rates_over_the_years
    assert_equal ({2004=>1.258, 2005=>0.96, 2006=>1.05, 2007=>0.992, 2008=>0.718, 2009=>0.652, 2010=>1.236, 2011=>1.211, 2012=>1.18, 2013=>1.189, 2014=>1.162}),
    ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_it_can_find_the_graduation_variation
  end

  def test_it_can_find_the_k_part_versus_graduation

  end
end
