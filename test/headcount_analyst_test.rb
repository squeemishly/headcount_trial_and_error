require_relative 'test_helper'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr,
              :ha

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners_in_a_full_day_program.csv"
      }
    })
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
    skip
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end

  def test_it_can_find_a_districts_average_participation
    assert_equal 0.285, ha.district_average("ACADEMY 20")
  end

  def test_it_compares_a_districts_average_participation_against_another_district
    skip
    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end
end
