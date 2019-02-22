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
    expected = {
      :encryption=>"qnhaxisd u ", 
      :key=>"02715", 
      :date=>"210219"
    }
    assert_equal expected, actual
  end

  def test_it_can_encrypt_messages_without_a_date_or_key
    actual = @enigma.encrypt("hello world")
    expected = {
      :encryption=>"ilmgpgxjsse", 
      :key=>"75221",
      :date=>"210219"
    }
    assert_equal expected, actual
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
    expected = {
      :decryption=>"zwpwfr zich",
      :key=>"02715", 
      :date=>"210219"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_an_instance_of_message
    message = @enigma.create_message("ooolala")
    assert_instance_of Message, message
  end

  def test_it_can_create_an_instance_of_date_with_a_date
    date = @enigma.create_date("210219")
    assert_instance_of DateShift, date
  end

  def test_it_can_create_a_date_without_given_a_date
    date = @enigma.create_date(nil)
    assert_instance_of DateShift, date
  end

  def test_it_can_create_an_instance_of_key_with_a_key
    key = @enigma.create_key("02715")
    assert_instance_of Key, key
  end

  def test_it_can_create_a_new_key_without_give_a_key
    key = @enigma.create_key(nil)
    assert_instance_of Key, key
  end 

  def test_it_can_create_an_encryption
    @enigma.create_message("ooolala")    
    @enigma.create_date("110231")
    @enigma.create_key("02312")
    actual = @enigma.create_encryption_or_decryption("encrypt")
    expected = {
      :encryption=>"tnyyfkk",
      :key=>"02312", 
      :date=>"110231"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_encryption_or_decryption
    @enigma.create_message("tnyyfkk")    
    @enigma.create_date("110231")
    @enigma.create_key("02312")
    actual = @enigma.create_encryption_or_decryption("decrypt")
    expected = {
      :decryption=>"ooolala",
      :key=>"02312", 
      :date=>"110231"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_encrypted_hash
    @enigma.create_key("02715") 
    @enigma.create_date("040895")
    actual = @enigma.encrypted_hash('encrypt', "hello world")
    expected = {
      :encryption=>"hello world",
      :key=>"02715", 
      :date=>"040895"
    }
    assert_equal expected, actual
  end

  def test_it_can_create_decrypted_hash
    @enigma.create_key("02715") 
    @enigma.create_date("040895")
    actual = @enigma.encrypted_hash('decrypt', "hello world")
    expected = {
      :decryption=>"hello world",
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

  # def test_it_can_crack_messages
  #   result = @enigma.crack("vjqtbeaweqihssi", "291018")
  #     expected = {
  #       decryption: "hello world end",
  #       date: "291018",
  #       key: "08304"
  #     }
  #   assert_equal expected, result
  # end
end