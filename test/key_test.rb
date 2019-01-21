require_relative 'test_helper'
require './lib/key'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new("02715")
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_it_generates_a_key_reference
    result = @key.generate_encrypted_keys(["1", "0", "2", "5"])
    expected = [3, 27, 73, 20]
    assert_equal expected, result
  end
end