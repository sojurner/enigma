require 'date'

module RandomGeneration
  def generate_key
    random_five_digit = Array.new(5, 0)
    random_five_digit.map {|_| rand(0..9) }.join
  end

  def date_today
    Date.today.strftime("%d%m%y") 
  end
end
