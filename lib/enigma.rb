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
end