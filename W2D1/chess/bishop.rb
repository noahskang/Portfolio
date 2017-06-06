require_relative 'Piece'
require_relative 'sliding_piece'

class Bishop < Piece 

  def initialize
    super
    @white_symbol = "\u265d"
    @black_symbol = "\u2657"
  end

protected

  def move_dirs()


end
