require_relative 'alphabet_key'

class Message
  include AlphabetKey
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def self.create_message(message)
    Message.new(message)
  end

  def grouped_message
    string_arr = []
    @message.chars.each_slice(4) {|group_array| string_arr << group_array}
    string_arr
  end

  def shift_grouped_values(string_arr, key_shift, command)
    string_arr.map.each_with_index do |char, index|
      shift_letter(char, key_shift[index], command)
    end.flatten
  end

  def encrypt_decrypt_characters(key_shift, command)
    grouped_message.map do |string_arr|
      shift_grouped_values(string_arr, key_shift, command)
    end.join('')
  end

  def shift_letter(letter, shift_val, command)
    initial_index = alphabet.index(letter.downcase)
    shifted_alphabet = control_cipher(shift_val, command)
    shifted_alphabet[initial_index]
  end

  def control_cipher(shift_val, command) 
    command == "encrypt" ? 
    alphabet.rotate(shift_val.to_i) :
    alphabet.rotate(shift_val.to_i * -1) 
  end
end
