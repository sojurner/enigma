require_relative 'key'
require_relative 'date_shift'
require_relative 'message'
require 'pry'

class Enigma

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

  def direct_message command
    shift = @date.date_offset
    keys = key.generate_encrypted_keys(shift)
    code = @message.encrypt_decrypt_characters(keys, command)
    {
      decryption: (code if command == "decrypt"),
      encryption: (code if command == "encrypt"),
      key: @key.key,
      date: @date.date
    }.compact

  end


end