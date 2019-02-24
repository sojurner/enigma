require_relative 'test_helper'
require './lib/enigma'
require './lib/random_generation'
require './lib/alphabet_key'

class EnigmaTest < Minitest::Test
  include AlphabetKey
  include RandomGeneration

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

  def test_it_can_encrypt_messages_without_a_date
    actual = @enigma.encrypt("hello world", "02715")
    has_date = actual.key?(:date)
    assert_equal "qnhaxisd u ", actual[:encryption]
    assert_equal "02715", actual[:key]
    assert has_date
  end

  def test_it_can_encrypt_messages_without_a_date_or_key
    encryption = @enigma.encrypt("hello world")
    assert encryption.key?(:key)
    assert encryption.key?(:date)
    assert encryption[:key]
    assert encryption[:date]
    assert encryption[:encryption]
  end

  def test_it_can_decrypt_messages
    actual = @enigma.decrypt('keder ohulw', '02715', '040895')
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, actual
  end

  def test_it_can_decrypt_messages_without_a_date
    actual = @enigma.decrypt("hello world", "02715")
    has_date = actual.key?(:date)
    assert_equal "zwpwfr zich", actual[:decryption]
    assert_equal "02715", actual[:key]
    assert has_date
  end

  def test_it_can_create_an_encryption
    arguments = ["keder ohulw", "02715", "040895"]
    @enigma.encrypt(*arguments)
    actual = @enigma.create_encryption_or_decryption("encrypt")
    expected = {
      :encryption=>"newyu gaxlo", 
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_encryption_or_decryption
    arguments = ["tnyyfkk", "02312",  "110231"]
    @enigma.decrypt(*arguments)
    actual = @enigma.create_encryption_or_decryption("decrypt")
    expected = {
      :decryption=>"ooolala",
      :key=>"02312", 
      :date=>"110231"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_decrypted_hash
    arguments = ["keder ohulw", "02715", "040895"]
    @enigma.decrypt(*arguments)
    actual = @enigma.cipher_hash('decrypt', "hello world")
    expected = {
      :decryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_encrypted_hash
    arguments = ["hello world", "02715", "040895"]
    @enigma.encrypt(*arguments)
    actual = @enigma.cipher_hash('encrypt', "kedur ohulw")
    expected = {
      :encryption=>"kedur ohulw",
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual
  end

  def test_it_can_refine_hash_based_on_missing_keys
    code_hash = {
      :encryption=>nil,
      :decryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    actual = @enigma.refine_hash(code_hash)
    expected = {
      :decryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual

    code_hash = {
      :decryption=>nil,
      :encryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    actual = @enigma.refine_hash(code_hash)
    expected = {
      :encryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual
  end
end