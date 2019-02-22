require './lib/message'

class MessageTest < Minitest::Test
  def setup
    @message = Message.new('hello world')
  end

  def test_it_exists
    assert_instance_of Message, @message
  end

  def test_it_starts_with_a_message
    assert_equal "hello world", @message.message
  end

  def test_it_can_group_message_into_fours
    expected = [
      ["h", "e", "l", "l"], 
      ["o", " ", "w", "o"], 
      ["r", "l", "d"]
    ]
    assert_equal expected, @message.grouped_message
  end

  def test_it_can_create_an_instance_of_message
    message = Message.create_message("ooolala")
    assert_instance_of Message, message
  end

  def test_can_encrpyt_characters
    result = @message.encrypt_decrypt_characters([3, 27, 73, 20], 'encrypt')
    expected = 'keder ohulw'
    assert_equal expected, result
  end

  def test_it_can_decrypt_characters
    @message = Message.new('keder ohulw')
    result = @message.encrypt_decrypt_characters([3, 27, 73, 20], 'decrypt')
    expected = 'hello world'
    assert_equal expected, result
  end

  def test_it_can_shift_letters
    actual = @message.shift_letter("h", 9, "encrypt")
    assert_equal "q", actual
  end

  def test_it_can_rotate_alphabet_based_on_encrypt_or_decrypt
    shift, command = 3, 'encrypt'
    actual = @message.control_cipher(shift, command)
    expected = ["d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c"]
    assert_equal expected, actual

    shift, command = 3, 'decrypt'
    actual = @message.control_cipher(shift, command)
    expected = ["y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x"]
    assert_equal expected, actual
  end
end