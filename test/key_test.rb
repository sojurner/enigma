require_relative 'test_helper'
require './lib/key'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new("02715")
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_it_generates_encrypted_keys
    expected = [3, 27, 73, 20]
    actual = @key.generate_encrypted_keys(["1", "0", "2", "5"])
    assert_equal expected, actual
  end

  def test_it_can_join_adjacent_keys
    key_set = ["4", "5", "9", "8", "9"]
    actual = @key.join_adjacent_keys(key_set)
    expected =  ["45", "59", "98", "89", nil]
    assert_equal expected, actual
  end

  def test_it_can_delete_nil_from_key_set
    key_set = ["02", "27", "71", "15", nil]
    expected = ["02", "27", "71", "15"]
    actual = @key.refine_keys(key_set)
    assert_equal expected, actual
  end

  def test_it_creates_new_keys_by_adding_prev_keys_together
    key = ["02", "27", "71", "15"]
    shift = ["1", "0", "2", "5"]
    actual = @key.shift_keys(key, shift)
    expected = [3, 27, 73, 20]
    assert_equal expected, actual
  end
end