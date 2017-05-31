class AIPlayer
  def initialize(name = "Bob")
    @name = name
  end

  def get_guess
    puts "Pick a card. e.g. 2, 3: "
    user_guess = arr_conversion(gets.chomp)


    user_guess
  end

  def arr_conversion(user_guess)
    user_guess.split(", ").map(&:to_i)
  end

  def to_s
    @name
  end
end
