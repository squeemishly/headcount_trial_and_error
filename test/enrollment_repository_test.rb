# require_relative 'test_helper'
# require './lib/enrollment_repository'
#
# class EnrollmentRepositoryTest < Minitest::Test
#   def setup
#     @er = EnrollmentRepository.new
#   end
#
#   def test_it_exists
#     assert_instance_of EnrollmentRepository, @er
#   end
#
#   def test_it_has_access_to_our_file
#     @er.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners_in_a_full_day_program.csv"}})
#     assert_equal "./data/Kindergartners in full-day program.csv", @er.file.path
#   end
#
#   def test_it_can_find_a_particular_district
#     @er.load_data(:enrollment => {:kindergarten => "./test/fixtures/Kindergartners_in_a_full_day_program.csv", :high_school => "./data/High school graduation rates.csv"})
#     assert_instance_of Enrollment, @er.find_by_name("ACADEMY 20")
#     refute @er.find_by_name("squee")
#   end
# end
# --------------------------------------------------------------------------------------
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'
require './lib/enrollment'
require './lib/district_repository'
require 'pry'

class EnrollmentRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.from_csv({
    :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })

    @er = @dr.enrollment
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @er.csv
  end

  def test_it_can_create_instance_of_transaction
    assert_instance_of Enrollment, @er.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @er.all
  end
end
