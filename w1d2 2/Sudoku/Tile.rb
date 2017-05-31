class Tile

  attr_accessor :value, :given

  def initialize(value)
    @value = value
    if value == 0
      @given = false
    else
      @given = true
    end
  end

  def update_tile(num)
    value = num

    given = true
  end

  def to_s
    return @value unless @value == 0
    " "
  end

  def ==(num)
    self.value == num 
  end
end
