require_relative 'test_helper'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :er

  def setup
    @er = EnrollmentRepository.new
    @er.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/High school graduation rates.csv"
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

  def test_it_can_access_graduation_rate_by_year
    skip
    assert_equal ({ 2010 => 0.895, 2011 => 0.895, 2012 => 0.889,
     2013 => 0.913, 2014 => 0.898,}), enrollment.graduation_rate_by_year
  end


end
