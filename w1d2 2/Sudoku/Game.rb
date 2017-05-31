class Game

  def initialize(board = Board.new)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      user_input = prompt

    end

    print "YOU WON THIS GAME."
  end

  def prompt
    print "Where do you want to place your number? e.g. row, col"
    selected_pos = convert(gets.chomp)

    if pos_valid?(selected_pos)
      print "What number do you want to place? "

      user_num = gets.chomp.to_i

      if @board.check_validity?(guess, user_num)
        @board.mark(pos, user_num)
      end
    else
      prompt
    end

  end

  def convert(pos)
    pos.split(", ").map(:&to_i)
  end

  def pos_valid?(pos)
    @board[pos] == 0
  end

end
