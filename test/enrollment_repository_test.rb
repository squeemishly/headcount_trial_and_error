require_relative 'test_helper'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :er

  def setup
    @er = EnrollmentRepository.new
    @er.load_data({
      :enrollment => {
        :high_school_graduation => "./test/fixtures/High school graduation rates.csv",
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
  end

  def test_it_exists
    assert_instance_of EnrollmentRepository, er
  end

  def test_it_creates_instances_of_enrollment_when_it_loads_the_data
    assert_instance_of Enrollment, er.enrollments[0]
    assert_instance_of Enrollment, er.enrollments[1]
    assert_instance_of Enrollment, er.enrollments[2]
  end

  def test_it_can_find_a_particular_district
    assert_instance_of Enrollment, er.find_by_name("ACADEMY 20")
    refute er.find_by_name("squee")
  end

  def test_it_can_create_information_for_both_kindergarten_and_high_school
    assert_equal "", er.enrollments[0]
  end


end
