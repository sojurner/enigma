require_relative 'alpha_numeric_date'

class Key
  include AlphaNumericDate

  attr_reader :key

  def initialize(key = random_five_digit_key)
    @key = key
  end
  
  def generate_encrypted_keys(shift)
    key_set = @key.chars 
    adjusted_keys = rotate_keys(key_set)
    parsed_keys = refine_keys(adjusted_keys)
    join_keys(parsed_keys, shift)
  end


    keys.map.with_index {|key, index|
      key.to_i + shift[index].to_i
    }
  end

end