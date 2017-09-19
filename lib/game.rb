require_relative './board'
require_relative './player'
require_relative './tools'
require 'pry'

class Game
  include Tools

  attr_reader :human_player, :computer_player, :log

  def initialize(board=Board.new)
    @board = board
    @log = []
  end

  def start
    human_player_mark = ask('Which player do you want to be? X or O').upcase

    if check_value(human_player_mark)
      notify("You have selected #{human_player_mark}.")
      @human_player    = Player.new('Player One', human_player_mark)
      @computer_player = Player.new('WOPR', other_mark(human_player_mark))
      play
    else
      uhoh("You must enter X or O.")
      restart
    end
  end

  def play
    until game_over?
      @board.draw
      square_selected = ask("Enter the square number to place #{human_player.mark}").to_i

      case @board.set(square_selected, human_player.mark)
      when -1
        uhoh("Please enter a value 1 to 9.")
      when nil
        uhoh("That spot has already been selected.")
      else
        log << [square_selected, human_player.mark]
        break if game_over?
        ai_move = computer_player.make_move(@board.available_squares)
        @board.set(ai_move, computer_player.mark)
        log << [ai_move, computer_player.mark]
      end
    end

    done
  end

  def done
    if game_is_won?(*log.last)
      alert("#{log.last.last} won on turn #{log.size}.")
    else
      alert("Game ended in a draw.")
    end

    @board.draw

    restart if ask("Would you like to play again? (Y/N)").upcase == 'Y'
  end

  def restart
    @board.reset
    @log.clear
    start
  end

  def game_over?
    log.size > 4 && (game_is_won?(*log.last) || game_is_a_draw?)
  end

  def game_is_a_draw?
    @board.full?
  end

  def win_conditions
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def win_conditions_for_square(square_number)
    win_conditions.select { |wc| wc.include?(square_number) }
  end

  def game_is_won?(last_square, mark)
    square_number = normalize_square_number(last_square)
    win_conditions_for_square(square_number).any? do |wc|
      wc.map do |s|
        @board.squares[s]
      end.all? { |c| c == mark }
    end
  end

end
