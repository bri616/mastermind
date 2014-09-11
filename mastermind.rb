class Mastermind
  attr_accessor :board
  def initialize
    @board = Board.new()
  end
end

class Board
  def initialize(number_of_turns=10)
    @top = "  |X X X X|    "
    @bottom = "   1 2 3 4     "
    @play_space = ["  |- - - -|    "]*number_of_turns
  end

  def draw
    puts @top
    @play_space.each {|line| puts line}
    puts @bottom
  end
end


# Needs a board and a way to save the guesses and feedback to the board
  # with colored pegs for guessing, smaller pegs of 2 colors for feedback
  # generate board based on the number of turns you want.
# secret sequence
# know when turns are up for game over

def run
  game = Mastermind.new()
  game.board.draw
end

run
