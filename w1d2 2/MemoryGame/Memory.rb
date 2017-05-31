require_relative 'Board'
require_relative 'Card'
require_relative 'Players'

class MemoryGame
  attr_accessor :grid, :players, :board

  def initialize(players = HumanPlayers.new)
    @players = players
    @board = Board.new
  end

  def play
    @players.register_board(@board)

    until @board.over?
      system("clear")

      @board.render

      pos1 = get_input
      pos2 = get_input

      unless board[pos1] == board[pos2]
        @board[pos1].hide
        @board[pos2].hide
      end

      sleep(2)
    end
    puts "#{@players}, you're a boss! you won :)"
  end

  def get_input
    user_guess = @players.get_guess

    until is_valid?(user_guess)
      puts "That card doesn't exist!"
      user_guess = @players.get_guess
    end


    @board[user_guess].reveal
    @board.render

    user_guess
  end

  def is_valid?(pos)
    x, y = pos
    return false if pos == nil
    return false if x > @board.grid.size || x < 0
    return false if y > @board.grid[0].size || y <0
    true
  end

end

if __FILE__ == $PROGRAM_NAME
  game = MemoryGame.new(AIPlayer.new)
  game.play
end
