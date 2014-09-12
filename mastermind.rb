require 'colorize'
class Mastermind
  attr_accessor :board
  def initialize
    @colors = [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white]
    @board = Board.new(@colors)
    @secret_sequence = random_sequence
  end

  def random_sequence(length=4)
    # does not allow for duplicates
    @colors.shuffle[0...length]
    # does allow for color duplicates
    # 4.times.collect {@colors.sample}
  end

end

class Board
  def initialize(colors, number_of_turns=10)
    @top = "  |X X X X|    "
    @bottom = "   1 2 3 4     "
    @play_space = ["  |- - - -|    "]*number_of_turns
    @colors = colors
  end

  def draw
    puts @top
    @play_space.each {|line| puts line}
    puts @bottom
    possible_color_str(@colors)
  end

  def possible_color_str(colors)
    @colors[0...4].each {|color| print color[0].colorize(color)+" "}
    puts "\n"
    @colors[4...8].each {|color| print color[0].colorize(color)+" "}
    puts "\n"
  end
end


# Needs a board and a way to save the guesses and feedback to the board
  # with colored pegs for guessing, smaller pegs of 2 colors for feedback
  # generate board based on the number of turns you want.
  # also show the possible colors you can use
# secret sequence
# allow players to enter a guess sequence
# check it against the secret one
# give feedback
# update the board with the guess sequence and the feedback
# know when turns are up for game over (if player guess never matches secret sequence)

def run
  game = Mastermind.new()
  game.board.draw

end

run
