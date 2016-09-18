require_relative 'card'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(4){[]})
    @grid = grid
    populate

  end

  def [](pos)
    return @grid[pos[0]][pos[1]]
  end

  def populate()
    card_array = []
    8.times do |c|
      2.times {|_| card_array << Card.new(c)}
    end
    #debugger
    card_array.shuffle!
    grid.each_with_index do |el, index|
      x = index
      y = card_array[0..3]
      #debugger
      grid[index].concat(card_array[0..3])
      card_array= card_array.drop(4)
    end
  end

  def render()
    #p @grid

    @grid.each do |row|
      row.each do |col|
        print "#{col.to_s} "
      end
      p " "
    end
end


  def won?()
    @grid.each do |el|
      return false unless el.all?{|card| card.face_up}
    end
    true
  end

  def reveal(guess_pos)
    @grid[guess_pos].reveal
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new()
  b.populate
  b.render
  #b.won?
  #p b.reveal([0,0])

end
