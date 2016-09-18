class HumanPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def receive_revealed_card(pos,value)  
  end

  def get_guess()
    puts("Input a guess: x,y")
    guess = gets.chomp.split(",")
    guess.map {|el| el.to_i}
  end
end
