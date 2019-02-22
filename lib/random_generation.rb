require 'date'

module RandomGeneration
  def generate_key
    random_five_digit = []
    5.times{ random_five_digit << rand(0..9) }
    random_five_digit.join
  end

  def date_today
    Date.today.strftime("%d%m%y") 
  end
end