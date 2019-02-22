require_relative 'random_generation'

class DateShift
  include RandomGeneration
  attr_reader :date

  def initialize(date = date_today) 
    @date = date
  end

  def self.create_date(date)
    !date ? DateShift.new : DateShift.new(date)
  end

  def date_offset
    date_squared = @date.to_i ** 2
    string_date = int_to_string(date_squared)
    last_four(string_date)
  end

  def int_to_string(int)
    int.to_s
  end

  def last_four(string_date)
    string_date.chars.last(4)
  end
end
