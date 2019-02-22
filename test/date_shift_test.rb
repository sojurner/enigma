require_relative 'test_helper'
require './lib/date_shift'

class DateShiftTest < Minitest::Test

  def setup
    @date_shift = DateShift.new("040895")
  end

  def test_it_exists
    assert_instance_of DateShift, @date_shift
  end

  def test_it_can_create_an_instance_of_date_with_a_date
    date = DateShift.create_date("210219")
    assert_instance_of DateShift, date
  end

  def test_it_can_create_a_date_without_given_a_date
    date = DateShift.create_date(nil)
    assert_instance_of DateShift, date
  end

  def test_it_creates_proper_offsets
    actual = @date_shift.date_offset
    expected = ["1", "0", "2", "5"]
    assert_equal expected, actual
  end

  def test_it_converts_int_to_string
    actual = @date_shift.int_to_string(4)
    assert_equal "4", actual
  end

  def test_it_extracts_last_four_digits
    actual = @date_shift.last_four("3321345")
    assert_equal ["1", "3", "4", "5"], actual
  end
end