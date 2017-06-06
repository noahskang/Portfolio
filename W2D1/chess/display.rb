require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display
  def initialize(board = Board.new)
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end

  def render
    @board.grid.each_with_index do |row, x|
      row.each_with_index do |col, y|
        piece = @board[[x, y]]
        if @cursor.cursor_pos == [x, y]
          print "#{piece} ".colorize(:color => :red, :background => :yellow)
        else
          print "#{piece} ".colorize(:background => :light_blue)
        end
      end
      puts "\n"
    end
    return ""
  end

  def play
    while true
      render
      @cursor.get_input
    end
  end

end

d = Display.new
d.play
