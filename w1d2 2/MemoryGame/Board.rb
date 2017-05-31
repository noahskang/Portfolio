require_relative 'Card'

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(2) { Array.new(2) })
    @grid = grid
    @values = random_values
    self.populate
  end

  def over?
    @grid.flatten.all? { |card| card.face_up? }
  end

  def render
    @grid.each do |row|
      row.each do |card|
        print "  #{card}  |"
      end

      puts "\n"
      puts "\n"
    end
  end

  def populate
    @grid.each do |row|
      row.each_with_index do |_, idx|
        row[idx] = Card.new(@values.pop)
      end
    end
  end

  def random_values
    random_values = []
    needed_length = @grid.flatten.size / 2

    until random_values.length == needed_length
      num = rand(10)
      random_values << num unless random_values.include?(num)
    end

    (random_values * 2).shuffle
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

end
