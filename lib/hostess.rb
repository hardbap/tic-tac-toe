require_relative './game'
require_relative './tools'
require_relative './view_helpers'

class Hostess
  include Tools
  include ViewHelpers

  attr_reader :game

  # Public: Start our game by prompting the human to select a mark.
  #
  # Returns nothing.
  def start
    human_player_mark = ask('Which player do you want to be? X or O: ').upcase

    if check_value(human_player_mark)
      notify("You have selected #{human_player_mark}.")
      play(human_player_mark)
    else
      uhoh('You must enter X or O.')
      start
    end
  end

  # Private: Play a game of tic-tac-toe.
  #
  # human_player_mark - The String mark the human has selected.
  #
  # Returns nothing.
  def play(human_player_mark)
    @game = Game.new(human_player_mark)

    until game.game_over?
      show_board
      square_selected = ask("Enter the square number to place your #{human_player_mark}: ").to_i

      case game.human_move(square_selected)
      when -1
        uhoh('Please enter a value 1 to 9.')
      when nil
        uhoh('That spot has already been selected.')
      else
        break if game.game_over?

        notify('[AI is thinking...]')

        game.ai_move
      end
    end

    wrapup
  end

  # Private: Wrap up a completed game of tic-tac-toe. Starts a new game if the
  # player chooses to do so.
  #
  # Returns nothing.
  def wrapup
    if game.check_winner
      alert("#{game.last_mark_placed} wins on turn #{game.turn_number}!")
    else
      alert('Game is a draw.')
    end

    show_board

    start if ask('Would you like to play again? (Y/N) ').upcase == 'Y'
  end

  # Private: Show the game board in its current state.
  #
  # Returns a String representation of the game board.
  def show_board

    sep = "\t+---+---+---+\n"
    output(sep)

    game.play_area.each_slice(3).each do |slice|
      output("\t| #{slice.join(' | ')} |")
      output(sep)
    end
  end
end
