module SlidingPiece

  HORIZONTAL_DIRS = [[-1,0], [1,0], [0,-1], [0,1]]
  DIAGONAL_DIRS = [[-1,-1], [-1,1], [1,-1], [1,1]]

  def moves
    move_array = []

    move_dirs.each do |dir|
      dx, dy = dir
      move_array.concat grow_unblocked_moves_in_dir(dx, dy)
    end
    move_array
  end

  def move_dirs
    if self.is_a?(Bishop)
      DIAGONAL_DIRS
    elsif self.is_a?(Rook)
      HORIZONTAL_DIRS
    else
      HORIZONTAL_DIRS + DIAGONAL_DIRS
    end
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    x, y = @start_pos
    newpos = [x + dx, y + dy]
    possible_positions = []

    while self.board.in_bounds(newpos)
      if self.board.empty?(newpos)
        possible_positions << newpos.dup
      else
        if self.same_team?(newpos)
          break
        else
          possible_positions << newpos.dup
          break
        end
      end
      newpos = [x + dx, y + dx]
    end

    possible_positions
  end

end
