# require_relative 'test_helper'
# require './lib/district_repository'
#
# class DistrictRepositoryTest < Minitest::Test
#   def setup
#     @dr = DistrictRepository.new
#   end
#
#   def test_it_exists
#     assert_instance_of DistrictRepository, @dr
#   end
#
#   def test_it_has_access_to_our_file
#     @dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
#     assert_equal "./data/Kindergartners in full-day program.csv", @dr.csv.path
#   end
#
#   def test_it_has_access_to_another_file
#     @dr.load_data({:enrollment => {:high_school_graduation => "./data/High school graduation rates.csv"}})
#     assert_equal "./data/High school graduation rates.csv", @dr.csv.path
#   end
#
#   def test_it_can_find_a_particular_district
#     @dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
#     assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20")
#     refute @dr.find_by_name("squee")
#   end
#
#   def test_it_can_find_a_district_from_a_name_fragment
#     @dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
#     assert_equal ["ASPEN 1"], @dr.find_all_matching("aspen")
#     assert_equal [], @dr.find_all_matching("squee")
#   end
#
#   def test_it_can_access_the_enrollment_repository
#     @dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
#     assert_instance_of EnrollmentRepository, @dr.enrollment_repository
#   end
#
#   def test_it_can_automatically_access_enrollment_data
#     skip
#     @dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
#     district = @dr.find_by_name("ACADEMY 20")
#     assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
#   end
# end
# --------------------------------------------------------------------------------------
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.from_csv({
    :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
  end

  def test_it_exists
    assert_instance_of DistrictRepository, @dr
  end

  def test_has_method_that_takes_hash_of_things_and_returns_a_district_repo
    assert_instance_of DistrictRepository, @dr
  end

  def test_data_files_return_instance_of_corresponding_repositories
    assert_instance_of EnrollmentRepository, @dr.enrollment
  end
end
