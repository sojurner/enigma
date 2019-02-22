require_relative "test_helper"

class ModuleTest < Minitest::Test
  include RandomGeneration
  include AlphabetKey

  def test_alphabet_key_generation
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    actual = alphabet
    assert_equal expected, actual
  end

  def test_generate_random_5_digit_key
    random_key = generate_key
    assert_equal 5, random_key.chars.length
    assert_instance_of String, random_key
  end

  def test_date_today
    assert_equal "210219", date_today
  end
end