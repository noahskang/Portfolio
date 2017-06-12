require_relative 'piece'
require_relative 'sliding_piece'
# require_relative 'board'

class Rook < Piece
include SlidingPiece

  def initialize(pos, color = :whatever, board)
    super
    @white_symbol = "\u2656"
    @black_symbol = "\u265c"
  end

end
