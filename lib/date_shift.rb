require_relative 'alpha_numeric_date'

class DateShift
  include AlphaNumericDate

  attr_reader :date

  def initialize(date = date_today) 
    @date = date
  end

  def date_offset
    squared = @date.to_i ** 2
    squared.to_s.split(//).last(4)
  end
end