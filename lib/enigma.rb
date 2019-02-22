require './lib/key'
require './lib/date_shift'
require './lib/message'

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
    @message = Message.create_message(message)
    @date = DateShift.create_date(date)
    @key = Key.create_key(key)
    create_encryption_or_decryption('encrypt')
  end

  def decrypt(cipher_message, key = nil, date = nil)
    @message = Message.create_message(cipher_message)
    @date = DateShift.create_date(date)
    @key = Key.create_key(key)
    create_encryption_or_decryption('decrypt')
  end

  def create_encryption_or_decryption(command)
    shift = @date.date_offset
    keys = @key.generate_encrypted_keys(shift)
    code = @message.encrypt_decrypt_characters(keys, command)
    cipher_hash(command, code)
  end

  def cipher_hash(command, code)
    code_hash = {
      decryption: (code if command == "decrypt"),
      encryption: (code if command == "encrypt"),
      key: @key.key,
      date: @date.date
    }
    refine_hash(code_hash)
  end

  def refine_hash(code_hash)
    code_hash.delete_if { |key, value| !value }
    code_hash
  end

  # def last_four_keys(shift, message)
  #   require 'pry'; binding.pry
  #   last_four = message[message.length - 4..-1].chars
  #   last_four.map {|letter| alphabet.index(letter)}
  # end

  # def crack(cipher_msg, key = nil, date)
  #   @message = Message.new(cipher_msg)
  #   !date ? @date = DateShift.new : @date = DateShift.new(date)
  #   shift = @date.date_offset.map {|letter| letter.to_i}
  #   alphabet_index
  #   require 'pry'; binding.pry
  #   @message.encrypt_decrypt_characters(x, 'encrypt')
  # end

  # def known_indices
  #   known_chars = " end".chars
  #   known_chars.map {|letter| alphabet.index(letter)}
  # end
end