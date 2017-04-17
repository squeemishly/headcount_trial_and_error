require_relative 'test_helper'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr,
              :ha

  def setup
    @dr = DistrictRepository.new
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_it_exists
    assert_instance_of HeadcountAnalyst, ha
  end
end
