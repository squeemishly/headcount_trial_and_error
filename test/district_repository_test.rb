require_relative 'test_helper'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  attr_reader :dr

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
        }})
  end

  def test_it_exists
    assert_instance_of DistrictRepository, dr
  end

  def test_it_makes_districts
    assert_instance_of District, dr.districts[0]
    assert_instance_of District, dr.districts[1]
    assert_instance_of District, dr.districts[2]
  end

  def test_it_can_find_a_particular_district
    assert_instance_of District, dr.find_by_name("ACADEMY 20")
    refute dr.find_by_name("squee")
  end

  def test_it_can_find_a_district_from_a_name_fragment
    assert_equal 1, dr.find_all_matching("aspen").count
    assert_equal 2, dr.find_all_matching("adams").count
    assert_equal [], dr.find_all_matching("squee")
  end

  def test_it_can_starts_with_an_enrollment_repo
    assert_instance_of EnrollmentRepository, dr.enrollment_repo
  end

  def test_it_can_automatically_access_enrollment_data
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
    assert_equal 11, district.enrollment.kindergarten_participation_by_year.length
  end
end
# --------------------------------------------------------------------------------------
# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/district_repository'
# require 'pry'
#
# class DistrictRepositoryTest < Minitest::Test
#
#   def setup
#     @dr = DistrictRepository.from_csv({
#     :enrollment => {
#       :kindergarten => "./data/Kindergartners in full-day program.csv"
#       }
#     })
#   end
#
#   def test_it_exists
#     assert_instance_of DistrictRepository, @dr
#   end
#
#   def test_has_method_that_takes_hash_of_things_and_returns_a_district_repo
#     assert_instance_of DistrictRepository, @dr
#   end
#
#   def test_data_files_return_instance_of_corresponding_repositories
#     assert_instance_of EnrollmentRepository, @dr.enrollment
#   end
# end
