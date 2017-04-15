require_relative 'test_helper'
require './lib/district'

class DistrictTest < Minitest::Test
  def test_it_exists
    d = District.new({:name => "ACADEMY 20"})
    assert_instance_of District, d
  end

  def test_it_returns_the_upcased_string_of_the_district
    district = District.new({:name => "colorado"})
    assert_instance_of District, district
    next_district = District.new({:name => "ACADEMY 20"})
    assert_instance_of District, next_district
  end
end
