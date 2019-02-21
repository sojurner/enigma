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
    message = @grouped_message.map { |arr|
      arr.map.each_with_index {|char, index|
        initial_index = alphabet.index(char.downcase)
        command == "encrypt" ? 
        shifted_alphabet = alphabet.rotate(key[index].to_i) : 
        shifted_alphabet = alphabet.rotate(key[index].to_i * -1) 
        char = shifted_alphabet[initial_index]
      }.join('')
    }.join('')
    message
  end


end