require './lib/message'

class MessageTest < Minitest::Test

  def setup
    @message = Message.new('hello world')
  end

  def test_it_exists
    assert_instance_of Message, @message
  end

  def test_can_encrpyt_characters
    result = @message.encrypt_decrypt_characters([3, 27, 73, 20], 'encrypt')
    expected = 'keder ohulw'
    
    assert_equal expected, result
  end

  def test_it_can_encrypt_characters
    @message = Message.new('keder ohulw')
    result = @message.encrypt_decrypt_characters([3, 27, 73, 20], 'decrypt')
    expected = 'hello world'

    assert_equal expected, result
  end
end