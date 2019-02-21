require_relative 'alpha_numeric_date'
require 'pry'

class Message
  include AlphaNumericDate

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def grouped_message
    string_arr = []
    @message.chars.each_slice(4) {|group_array| string_arr << group_array}
    string_arr
  end

  def encrypt_decrypt_characters(key, command)
    grouped_message.map do |string_arr|
      string_arr.map.each_with_index do |char, index|
        initial_index = alphabet.index(char.downcase)
        shifted_alphabet = control_cipher(key, index, command)
        char = shifted_alphabet[initial_index]
      end.flatten
    end.join('')
  end

  def control_cipher(key, index, command) 
    if command == "encrypt"
      alphabet.rotate(key[index].to_i)
    else
      alphabet.rotate(key[index].to_i * -1) 
    end
  end
end
