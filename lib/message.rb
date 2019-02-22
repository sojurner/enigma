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

  def encrypt_decrypt_characters(key, command)
    grouped_message.map do |string_arr|
      string_arr.map.each_with_index do |char, index|
        shift_letter(char, key[index], command)
      end.flatten
    end.join('')
  end

  def shift_letter(letter, shift, command)
    initial_index = alphabet.index(letter.downcase)
    shifted_alphabet = control_cipher(shift, command)
    shifted_alphabet[initial_index]
  end

  def control_cipher(shift, command) 
    case(command)
    when "encrypt"
      alphabet.rotate(shift.to_i)
    else
      alphabet.rotate(shift.to_i * -1) 
    end
  end
end
