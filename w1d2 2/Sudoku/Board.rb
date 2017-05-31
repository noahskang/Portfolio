require_relative 'Tile'

class Board

  attr_accessor :grid, :position

  def initialize(grid = self.from_file)
    @grid = grid
    @position
  end

  def self.from_file
# factory method to read and parse file into 2d array containing tile instances
    ary = File.readlines("Sudoku1.txt").map(&:chomp)
    ary.map!{|el| el.split("")}
    ary.map! do |row|
      row.map! {|el| Tile.new(el.to_i)}
    end

    Board.new(ary)
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print "  #{tile}  |"
      end
    end
  end

  def solved?
    @grid.flatten.none? { |tile| tile.value == 0 }
  end

  def check_validity?(num, pos)
    @position = pos

    return false unless (1..9).include?(num)
    return false if row_includes?(num) || column_includes?(num) || sector_includes?(num)
  end

  def row_includes?
  end

  def mark
    
  end

  def column_includes?

  end

  def sector_includes?
  num

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

end
