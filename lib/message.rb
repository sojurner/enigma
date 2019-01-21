require_relative 'alpha_numeric_date'
require 'pry'

class Message
  include AlphaNumericDate

  attr_reader :message

  def initialize(message)
    @grouped_message = []
    @message = message.split(//).each_slice(4) {|arr| @grouped_message << arr}
  end

  def encrypt_decrypt_characters(key, command)
    message = @grouped_message.map { |arr|
      arr.map.each_with_index {|char, index|
        initial_index = alphabet.index(char)
        command == "encrypt" ? 
        shifted_alphabet = alphabet.rotate(key[index]) : 
        shifted_alphabet = alphabet.rotate(key[index] * -1) 
        char = shifted_alphabet[initial_index]
      }.join('')
    }.join('')
    message
  end


end