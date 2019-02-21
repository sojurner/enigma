require './lib/key'
require './lib/date_shift'
require './lib/message'

class Enigma
  include AlphaNumericDate

  attr_reader :message, 
              :key, 
              :date

  def initialize
    @message= nil
    @key = nil
    @date = nil
  end

  def encrypt(message, key = nil, date = nil)
    @message = Message.new(message)
    !date ? @date = DateShift.new : @date = DateShift.new(date)
    !key ? @key = Key.new : @key = Key.new(key)
    direct_message('encrypt')
  end

  def decrypt(cipher_message, key = nil, date = nil)
    @message = Message.new(cipher_message)
    !date ? @date = DateShift.new : @date = DateShift.new(date)
    !key ? @key = Key.new : @key = Key.new(key)
    direct_message('decrypt')
  end

  def crack(cipher_msg, key = nil, date)
    @message = Message.new(cipher_msg)
    !date ? @date = DateShift.new : @date = DateShift.new(date)
    shift = @date.date_offset.map {|letter| letter.to_i}
    alphabet_index
    require 'pry'; binding.pry
    @message.encrypt_decrypt_characters(x, 'encrypt')
  end

  def last_four_keys(shift, message)
    require 'pry'; binding.pry
    last_four = message[message.length - 4..-1].chars
    last_four.map {|letter| alphabet.index(letter)}
  end

  def direct_message(command)
    shift = @date.date_offset
    keys = @key.generate_encrypted_keys(shift)
    code = @message.encrypt_decrypt_characters(keys, command)
    create_encryption(command, code)
  end

  def create_encryption(command, code)
    code_hash = {
      decryption: (code if command == "decrypt"),
      encryption: (code if command == "encrypt"),
      key: @key.key,
      date: @date.date
    }
    refine_hash(code_hash)
  end

    code_hash
  end


end