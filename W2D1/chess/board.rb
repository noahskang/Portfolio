require_relative 'piece'
require_relative 'null_piece'

class Board

  attr_reader :grid

  def initialize(grid = Board.populate_grid)
    @grid = grid
  end

  def self.populate_grid
    board = Array.new(8) { Array.new(8) }

    board.each_with_index do |row, x|
      row.map!.with_index do |ele, y|
        if x.between?(0,1)
          ele = Piece.new([x, y], :white)
        elsif x.between?(2,5)
          ele = NullPiece.new([x, y])
        else
          ele = Piece.new([x, y], :black)
        end
      end
    end
    board
  end

  def move_piece(start_pos, end_pos)
    raise Exception.new("no piece there") if self[start_pos].is_a?(NullPiece)
    raise Exception.new("position is occupied") if !self[end_pos].is_a?(NullPiece)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def [](pos)
    x, y =pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y =pos
    @grid[x][y]=value
  end

  def in_bounds(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

end
