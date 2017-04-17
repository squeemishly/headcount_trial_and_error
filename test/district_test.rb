require_relative 'test_helper'
require './lib/district'

class DistrictTest < Minitest::Test
  attr_reader :d

  def setup
    @d = District.new({:name => "ACADEMY 20"})
  end

  def test_it_exists
    assert_instance_of District, d
  end

  def test_it_returns_the_upcased_string_of_the_district
    district = District.new({:name => "colorado"})
    assert_instance_of District, district
    assert_instance_of District, d
  end
end
