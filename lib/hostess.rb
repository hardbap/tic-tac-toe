require_relative './game'
require_relative './tools'

class Hostess
  include Tools

  attr_reader :game

  def initialize
    @game = Game.new
  end

  def start
    human_player_mark = ask('Which player do you want to be? X or O ').upcase

    if check_value(human_player_mark)
      notify("You have selected #{human_player_mark}.")
      play(human_player_mark)
    else
      uhoh("You must enter X or O.")
      start
    end
  end

  def play(human_player_mark)
    game.start(human_player_mark)

    until game.game_over?
      show_board
      square_selected = ask("Enter the square number to place your #{human_player_mark}").to_i

      case game.human_move(square_selected)
      when -1
        uhoh("Please enter a value 1 to 9.")
      when nil
        uhoh("That spot has already been selected.")
      else
        game.log_human_move(square_selected)

        break if game.game_over?

        notify("[AI is thinking...]")
        game.log_ai_move(game.ai_move)
      end
    end

    wrapup
  end

  def wrapup
    if game.check_winner
      alert("#{game.last_mark_placed} wins on turn #{game.turn_number}!")
    else
      alert("Game is a draw.")
    end

    show_board

    go_again if ask("Would you like to play again? (Y/N) ").upcase == 'Y'
  end

  def go_again
    game.restart
    start
  end

  def show_board

    sep = "\t+---+---+---+\n"
    output(sep)

    game.play_area.each_slice(3).each do |slice|
      output("\t| #{slice.join(' | ')} |")
      output(sep)
    end

  end

end
