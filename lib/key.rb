require_relative 'random_generation'

class Key
  include RandomGeneration

  attr_reader :key

  def initialize(key = generate_key)
    @key = key
  end
  
  def generate_encrypted_keys(shift)
    key_set = @key.chars 
    adjusted_keys = join_adjacent_keys(key_set)
    parsed_keys = refine_keys(adjusted_keys)
    shift_keys(parsed_keys, shift)
  end

  def join_adjacent_keys(key_set)
    key_set.map.with_index do |char, index| 
      next_key = key_set[index+ 1] 
      "#{key_set[index]}#{key_set[index+1]}" if next_key
    end
  end

  def refine_keys(keys)
    keys.reject {|key| !key}
  end

  def shift_keys(key_set, shift)
    key_set.map.with_index do |key, index|
      key.to_i + shift[index].to_i
    end
  end
end