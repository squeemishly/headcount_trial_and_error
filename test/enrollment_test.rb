require_relative 'test_helper'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test
  attr_reader :e, :enrollment

  def setup
    @e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    @enrollment = Enrollment.new({:name => "ACADEMY 20", :high_school_graduation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
  end

  def test_it_exists
    assert_instance_of Enrollment, e
  end

  def test_it_parses_the_data_into_a_hash
    assert_equal [2010, 2011, 2012], e.kindergarten_participation_by_year.keys
    assert_equal [0.3915, 0.35356, 0.2677], e.kindergarten_participation_by_year.values
  end

  def test_it_can_find_a_particular_years_results
    assert_equal 0.392, e.kindergarten_participation_in_year(2010)
  end

  def test_it_can_access_graduation_rate_by_year
    assert_equal [2010, 2011, 2012], enrollment.graduation_rate_by_year.keys
    assert_equal [0.3915, 0.35356, 0.2677], enrollment.graduation_rate_by_year.values
  end

  def test_it_can_determine_the_graduation_rate_for_a_single_year
    assert_equal 0.392, enrollment.graduation_rate_in_year(2010)
  end
end
# ------------------------------------------------------------------------
# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/enrollment'
# require './lib/district_repository'
# require './lib/enrollment_repository'
# require 'pry'
#
# class EnrollmentTest < Minitest::Test
#
#   def setup
#     @dr = DistrictRepository.from_csv({
#     :enrollment => {
#       :kindergarten => "./data/Kindergartners in full-day program.csv"
#       }
#     })
#
#     @e = Enrollment.new({
#       :location => "ACADEMY 20",
#       :timeframe => 2004,
#       :dataformat => "Percent",
#       :data => 0.30201
#       }, @dr.enrollment)
#   end
#
#   def test_it_exists
#     assert_instance_of Enrollment, @e
#   end
# end
