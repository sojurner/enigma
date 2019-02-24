require_relative 'random_generation'

class Key
  include RandomGeneration
  attr_reader :key

  def initialize(key = generate_key)
    @key = key
  end

  def self.create_key(key)
    !key ? Key.new : Key.new(key)
  end
  
  def generate_encrypted_keys(date_shift)
    adjusted_keys = join_adjacent_keys(@key.chars )
    parsed_keys = refine_keys(adjusted_keys)
    shift_keys(parsed_keys, date_shift)
  end

  def join_adjacent_keys(key_set)
    key_set.map.with_index do |current_key, index| 
      next_key = key_set[index+ 1] 
      "#{current_key}#{next_key}" if next_key
    end
  end

  def refine_keys(keys)
    keys.reject {|key| !key}
  end

  def shift_keys(key_set, date_shift)
    key_set.map.with_index do |key, index|
      places_to_shift = date_shift[index]
      key.to_i + places_to_shift.to_i
    end
  end
end