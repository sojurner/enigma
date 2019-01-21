require_relative 'alpha_numeric_date'

class Key
  include AlphaNumericDate

  attr_reader :key

  def initialize(key = random_five_digit_key)
    @key = key
  end

  def generate_encrypted_keys(shift)
    individual_key = @key.split(//) 
    keys = individual_key.map.with_index { |char, index| 
      individual_key[index+ 1] ? 
      "#{individual_key[index]}#{individual_key[index+1]}" : 
      nil
    }.reject {|e| e.to_s.empty?}

    keys.map.with_index {|key, index|
      key.to_i + shift[index].to_i
    }
  end

end