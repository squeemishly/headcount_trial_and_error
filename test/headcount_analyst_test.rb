require_relative 'test_helper'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr,
              :ha

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    # @dr.load_data({
    #   :enrollment => {
    #     :kindergarten => "./test/fixtures/Kindergartners_in_a_full_day_program.csv"
    #   }
    # })
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
    assert_equal 0.406, ha.district_average("ACADEMY 20")
  end

  def test_it_compares_a_districts_average_participation_against_another_district
    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_it_compares_a_districts_participation_rates_over_the_years
    assert_equal [2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014],
    ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO').keys

    assert_equal [1.258, 0.961, 1.05, 0.992, 0.718, 0.652, 0.681, 0.728, 0.689, 0.694, 0.661],
    ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO').values
  end
end
