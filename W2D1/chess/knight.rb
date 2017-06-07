require_relative 'piece'
require_relative 'stepping_piece'
# require_relative 'board'
# require_relative 'king'

class Knight < Piece
include SteppingPiece

  def initialize(pos, color = :whatever, board)
    super
    @white_symbol = "\u2658"
    @black_symbol = "\u265e"
  end

end

# board = Board.new
# knight = Knight.new([3,3], :white, board)
# p knight.moves
