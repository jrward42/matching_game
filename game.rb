require_relative 'card'
require_relative 'board'
require_relative 'humanplayer'
require_relative 'computerplayer'

class Game

attr_accessor :board, :previous_pos, :players

def initialize(players, board = Board.new)
  @board = board
  @players = players
end

def current_player
  players[0]
end

def over?
  board.won?
end

def play
  #debugger
  until over?
    2.times do
      play_turn
    end
    next_player!
  end
  puts "You win !!! "
end

def play_turn
  system("clear")
  board.render
  guessed_pos = get_guess(current_player)
  update_board(guessed_pos)
end

def get_guess(player)
  current_player.get_guess
end

def next_player!

  @players[0],@players[1] = @players[1],@players[0]
end

def update_board(guessed_pos)
  val = @board[guessed_pos].reveal
  players.each {|player| player.receive_revealed_card(guessed_pos,val)}
  system("clear")
  board.render
  sleep(3)
  if @previous_pos.nil?
    @previous_pos = guessed_pos
  else
    if @board[guessed_pos]==@board[@previous_pos]
      @board[guessed_pos].set_matched
      @board[previous_pos].set_matched
    else
      @board[guessed_pos].hide
      @board[@previous_pos].hide
    end
    @previous_pos = nil
  end
end

end

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new("Jessica")
  p2 = ComputerPlayer.new("Billy")
  a = Game.new([p1,p2])
  #p a
  a.play
end
