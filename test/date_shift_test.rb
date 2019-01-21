require_relative 'test_helper'
require './lib/date_shift'

class DateShiftTest < Minitest::Test

  def setup
    @date_shift = DateShift.new("040895")
  end

  def test_it_exists
    assert_instance_of DateShift, @date_shift
  end

  def test_it_creates_proper_offsets
    result = @date_shift.date_offset
    expected = ["1", "0", "2", "5"]

    assert_equal expected, result
  end
end