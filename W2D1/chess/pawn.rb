require_relative 'piece'
require_relative 'stepping_piece'
# require_relative 'board'

class Pawn < Piece
  def initialize(pos, color = :whatever, board)
    super
    @white_symbol = "\u2659"
    @black_symbol = "\u265f"
  end

  def moves
    forward_steps.concat(side_attacks)
  end

  def at_start_row?
    @current_pos == @start_pos
  end

  def forward_dir
    @color == :white ? 1 : -1
  end

  def forward_steps
    x, y = @start_pos
    step = forward_dir
    if at_start_row?
      [[x + step, y], [x + step * 2, y ]]
    else
      [[x + step, y ]]
    end
  end

  def side_attacks
    x, y = @start_pos
    possible_moves = []
    step = forward_dir
    possible_moves << [x + step, y + 1]
    possible_moves << [x + step, y - 1]
    possible_moves.reject { |move| same_team?(move) || @board.empty?(move) }
  end

end

# board = Board.new
# pawn = Pawn.new([1,1], :white, board)
# p pawn.moves
