# require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'pawn'
require 'byebug'

class Board

  attr_reader :grid

  def initialize(grid=nil)
    grid ||= populate_grid
    @grid = grid
  end

  def populate_grid
    board = Array.new(8) { Array.new(8) }

    board.each_with_index do |row, x|
      if x.between?(2,5)
        row.size.times {|i| row[i] = NullPiece.new([x, i], :whatever, self)}
      elsif x == 1
        row.size.times {|i| row[i] = Pawn.new([x, i], :white, self)}
      elsif x == 6
        row.size.times {|i| row[i] = Pawn.new([x, i], :black, self)}
      else
        board[x] = set_non_pawns(x)
      end
    end
    board
  end

  def set_non_pawns(row)
    color = :white if row == 0
    color = :black if row == 7
    ary = []
    ary << Rook.new([row, 0], color, self)
    ary << Knight.new([row, 1], color, self)
    ary << Bishop.new([row, 2], color, self)
    if row == 0
      ary << King.new([row, 3], color, self)
      ary << Queen.new([row, 4], color, self)
    else
      ary << Queen.new([row, 3], color, self)
      ary << King.new([row, 4], color, self)
    end
    ary << Bishop.new([row, 5], color, self)
    ary << Knight.new([row, 6], color, self)
    ary << Rook.new([row, 7], color, self)
    ary
  end

  def move_piece(start_pos, end_pos)
    raise Exception.new("no piece there") if self[start_pos].is_a?(NullPiece)
    raise Exception.new("position is occupied") if self[end_pos].color == self[start_pos].color
    # raise Exception unless self[start_pos].moves.include?(end_pos)

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

  def empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def in_check?(team)
    king = @grid.flatten.select{ |piece| piece.is_a?(King) && piece.color == team }
    king_pos = king.first.current_pos
    enemies = @grid.flatten.select { |piece| piece.color != team && piece.color != :whatever }
    enemies.any? { |enemy| enemy.moves.include?(king_pos) }
  end

  def checkmate?(team)
    my_team = @grid.select { |piece| piece.color == team }
    my_team.all? { |piece| piece.valid_moves.empty? } && in_check?(team)
  end

  def dup
    newgrid = @grid.map do |row|
      row.map do |ele|
        ele.double
      end
    end
    Board.new(newgrid)
  end

  def move_piece!(start_pos, end_pos)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end


end

board = Board.new
p board[[1,0]].valid_moves
