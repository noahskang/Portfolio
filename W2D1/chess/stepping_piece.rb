
module SteppingPiece

  KNIGHT_DIRS = [[-2,1],[-2,-1],[-1,-2],[1,-2],[-1,2],[1,2],[2,1],[2,-1]]

  KING_DIRS = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]

  def moves
    potential_moves = []

    if self.is_a?(King)
      KING_DIRS.each {|el| potential_moves << move_diffs(el)}
    else
      KNIGHT_DIRS.each {|el| potential_moves << move_diffs(el)}
    end

    potential_moves
  end

  def move_diffs(direction)
    dx, dy = direction
    x, y = @start_pos
    [x + dx, y + dy]

    # unless self.board.empty?(newpos)
    #   if self.same_team?(newpos)
    #
    #   else
    #     possible_positions << newpos.dup
    #     break
    #   end

  end

end
