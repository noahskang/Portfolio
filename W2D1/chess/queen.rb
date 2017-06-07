require_relative 'piece'
require_relative 'sliding_piece'
# require_relative 'board'

class Queen < Piece
include SlidingPiece

  def initialize(pos, color = :whatever, board)
    super
    @white_symbol = "\u2655"
    @black_symbol = "\u265b"
  end

end
