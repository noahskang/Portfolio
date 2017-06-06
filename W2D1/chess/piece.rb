class Piece
  attr_reader :symbol

  def initialize(pos, color = :whatever)
    @color = color
    @start_pos = pos
    @white_symbol = nil
    @black_symbol = nil
  end

  def to_s
    if @color == :black
      @black_symbol
    else
      @white_symbol
    end
  end

  def moves
    moves = []
  end

end
