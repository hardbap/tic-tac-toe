require_relative './board'
require_relative './player'
require_relative './tools'

class Game
  include Tools

  attr_reader :human_player, :computer_player, :log

  def initialize(board=Board.new)
    @board = board
    @log = []
  end

  def start(human_player_mark)
    @human_player    = Player.new('Player One', human_player_mark)
    @computer_player = Player.new('WOPR', other_mark(human_player_mark))
  end

  def human_move(square)
    @board.set(square, human_player.mark)
  end

  def ai_move
    computer_player.make_move(@board.available_squares).tap do |square|
      @board.set(square, computer_player.mark)
    end
  end

  def last_move
    log.last
  end

  def play_area
    @board.squares
  end

  def turn_number
    log.count
  end

  def log_human_move(square)
    log << [square, human_player.mark]
  end

  def log_ai_move(square)
    log << [square, computer_player.mark]
  end

  def restart
    @board.reset
    @log.clear
  end

  def check_winner
    game_is_won?(*last_move)
  end

  def last_mark_placed
    last_move.last
  end

  def game_over?
    legal_game? && (check_winner || game_is_a_draw?)
  end

  def legal_game?
    log.size > 4
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

  def game_is_won?(square, mark)
    square_number = normalize_square_number(square)
    win_conditions_for_square(square_number).any? do |wc|
      wc.map do |s|
        @board.squares[s]
      end.all? { |c| c == mark }
    end
  end

end