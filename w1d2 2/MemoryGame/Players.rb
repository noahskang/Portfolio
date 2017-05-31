require_relative 'Memory'
require_relative 'Card'
require_relative 'Board'

class Players
  def initialize(name = "Bob")
    @name = name
  end

  def to_s
    @name
  end

end

class HumanPlayers < Players
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

class AIPlayer < Players
  attr_accessor :discoveries, :board, :grid

  def initialize
    @discoveries = {}
    @second_guess = [nil, nil]
    @positions
    @grid.each_with_index do |row, idx1|
      row.each_with_index do |ele, idx2|
        @positions << [idx1, idx2]
      end
    end
  end

  def get_guess
    return @second_guess unless @second_guess == [nil, nil]

    @grid.each_with_index do |row, idx1|
      row.each_with_index do |ele, idx2|
        @second_guess = @discoveries[ele] if seen?(ele)
        return [idx1, idx2]
      end
    end
  end

  def seen?(value)
    @discoveries.has_key?(value)
  end

  def register_board(board)
    @board = board
    @grid = @board.grid
  end

end
