class Card

  attr_accessor :value, :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def face_up?
    @face_up
  end

  def to_s
    return @value.to_s if face_up?
    "X"
  end

  def ==(card)
    self.value == card.value
  end
end
