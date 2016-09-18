require_relative 'board'
require_relative 'game'

class Card
  attr_accessor :value, :face_up, :matched

  def initialize(value, face_up = false )
    @value = value
    @face_up = face_up
    @matched = false
  end

  def == (card)
    self.value == card.value
  end

  def hide
    @face_up = false unless matched == true
  end

  def reveal
    unless @face_up
      @face_up = true
      return value
    end
  end

  def set_matched
    matched = true 
  end

  def to_s
    return face_up ? value  : "X"
  end

end
