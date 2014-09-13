require 'colorize'
require 'set'
class Mastermind
  attr_accessor :board, :game_over
  def initialize
    @colors = [:black, :red, :green, :yellow, :light_blue, :magenta, :cyan, :white]
    @board = Board.new(@colors)
    @secret_sequence = random_sequence
    @game_over = false
    @turn_number = 0
  end

  def check_guess(guess)
    if guess.chars == @secret_sequence
      puts "Yay!"
      @game_over = true
    else
      check_each(guess)
      puts @secret_sequence.join
      puts "Black pegs: #{@loc_pegs}"
      puts "White pegs: #{@color_pegs}"
    end
  end

  def check_each(guess)
    @loc_pegs = 0
    @color_pegs = check_color_matches(guess)
    guess.chars.each_with_index do |pin, index|
      if pin == @secret_sequence[index]
        # the location AND color are right
        @loc_pegs += 1
      end
    end
    @color_pegs = @color_pegs-@loc_pegs
    @board.add_turn(@turn_number,guess, @color_pegs, @loc_pegs)
    @turn_number += 1
  end

  def check_color_matches(guess)
    (guess.chars & @secret_sequence).length
  end


  def first_letters(array)
    array.collect {|a| a[0]}
  end

  def random_sequence(length=4)
    # does not allow for duplicates
    first_letters(@colors.shuffle[0...length])
    # does allow for color duplicates
    # 4.times.collect {@colors.sample}
  end
end

class Board
  def initialize(colors, number_of_turns=10)
    @top = "  |X X X X|    "
    @bottom = "   1 2 3 4     "
    @number_of_turns = number_of_turns
    @play_space = ["  |- - - -|    "]*@number_of_turns
    @colors = colors
  end

  def current_turn_line(g,f)
    ["  |#{g[0]} #{g[1]} #{g[2]} #{g[3]}|#{f[0]}#{f[1]}#{f[2]}#{f[3]}"]
  end

  def add_turn(turn_number, user_guess, color_feedback_pegs, location_feedback_pegs)
    @play_space[@number_of_turns - turn_number] = current_turn_line(guess_peg_strings(user_guess), feedback_strings(color_feedback_pegs, location_feedback_pegs))
  end

  def guess_peg_strings(guess)
    guess.chars.collect {|g| "*".colorize((@colors.select {|n| n if n[0] == g})[0])}
  end

  def feedback_strings(color_pegs, location_pegs)
    f = ["","","",""]
    i=0
    color_pegs.times do |n|
      f[i] = "o".colorize(:white)
      i += 1
    end

    location_pegs.times do |n|
      f[i] ="o".colorize(:black)
      i += 1
    end

    f

  end

  def draw
    puts @top
    @play_space.each {|line| puts line}
    puts @bottom
    possible_color_str(@colors)
  end

  def possible_color_str(colors)
    print "   "
    @colors[0...4].each {|color| print color[0].colorize(color)+" "}
    puts "\n"
    print "   "
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
  while !game.game_over
    game.board.draw
    puts "Enter a guess sequence:"
    print ">"
    guess = gets.chomp
    game.check_guess(guess)
  end


end

run
