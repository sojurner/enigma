require_relative 'test_helper'
require './lib/enigma'
require './lib/alpha_numeric_date'

class EnigmaTest < Minitest::Test
  include AlphaNumericDate

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_encrypt_messages
    result = @enigma.encrypt('hello world', "02715", "040895")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    
    assert_equal expected, result
  end

  def test_it_can_decrypt_messages
    result = @enigma.decrypt('keder ohulw', '02715', '040895')

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
  end

  def test_it_can_crack_messages
    result = @enigma.crack("vjqtbeaweqihssi", "291018")
      expected = {
        decryption: "hello world end",
        date: "291018",
        key: "08304"
      }
    assert_equal expected, result
  end
end