require_relative './board'
require_relative './player'
require_relative './tools'

# Public: Handles our Game state.

class Game
  include Tools

  attr_reader :human_player, :computer_player, :log

  # Public: Initialize a Game.
  #
  # human_player_mark - A String indicating the human player's mark.
  # board             - A Board to be used for the game (default: Board.new).
  def initialize(human_player_mark, board=Board.new)
    @board = board
    @log = []

    @human_player    = Player.new('Player One', human_player_mark)
    @computer_player = Player.new('WOPR', other_mark(human_player_mark))
  end

  # Public: Make a move on the human player's behalf.
  #
  # square - The Integer square the player has selected.
  #
  # Returns result from Board#set.
  def human_move(square)
    @board.set(square, human_player.mark).tap do |result|
      log_human_move(square) if result == human_player.mark
    end
  end

  # Pubilc: Make the move for the AI.
  #
  # Returns the Integer of the square selected by AI.
  def ai_move
    computer_player.make_move(@board.available_squares).tap do |square|
      @board.set(square, computer_player.mark)
      log_ai_move(square)
    end
  end

  # Public: The last move made.
  #
  # Returns an Array [Integer, String] with the square and mark.
  def last_move
    log.last
  end

  # Public: The play area for the game.
  #
  # Returns an Array of Integers and/or Strings. Integers indicate empty spaces.
  def play_area
    @board.squares
  end

  # Public: The number of turns completed.
  #
  # Returns an Integer.
  def turn_number
    log.count
  end

  # Public: Logs a move by the human player.
  #
  # Returns an Array with all the moves.
  def log_human_move(square)
    log << [square, human_player.mark]
  end

  # Public: Logs a move by the AI.
  #
  # Returns an Array with all the moves.
  def log_ai_move(square)
    log << [square, computer_player.mark]
  end

  # Public: The last mark placed.
  #
  # Returns a String of the last mark played.
  def last_mark_placed
    last_move.last
  end

  # Public: The last square played.
  #
  # Returns an Integer where the last mark was placed.
  def last_square_marked
    last_move.first
  end

  # Public: Checks if the game is over. The game is over when at least 5 turns
  # are completed and there is a winner or the game is drawn.
  #
  # Returns TrueClass or FalseClass.
  def game_over?
    legal_game? && (check_winner || game_is_a_draw?)
  end

  # Public: Checks if the game is legit. A legal game has completed at least 5
  # turns.
  #
  # Returns TrueClass or FalseClass.
  def legal_game?
    log.size > 4
  end

  # Public: Checks if the game is a draw.
  #
  # Returns TrueClass or FalseClass.
  def game_is_a_draw?
    # NOTE: This is most likely not optimal. The board could be full but not
    # drawn. This should really be the inverse of #game_is_won? but this will
    # be okay for our MVP.
    @board.full?
  end

  # Public: Checks if the last move one the game.
  #
  # Returns TrueClass or FalseClass.
  def check_winner
    # NOTE: This could be improved by checking the entire board for a win.
    game_is_won_at_square?(last_square_marked)
  end

  # Private: All possible victory conditions.
  #
  # Returns an Array of Arrays containing Integers.
  def win_conditions
    [
      # rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      # columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      # diagonals
      [0, 4, 8],
      [2, 4, 6],
    ]
  end

  # Private: All the win conditions for the given square.
  #
  # square_number - The Integer square to get win conditions.
  #
  # Retuns an Array of Arrays containing Integers.
  def win_conditions_for_square(square_number)
    win_conditions.select { |wc| wc.include?(square_number) }
  end

  # Private: Checks if the game has been won by the given move.
  #
  # square - The Integer square to check.
  #
  # Returns TrueClass or FalseClass.
  def game_is_won_at_square?(square)
    square_number = normalize_square_number(square)
    mark = @board.squares[square_number]
    win_conditions_for_square(square_number).any? do |wc|
      play_area.values_at(*wc).all? { |c| c == mark }
    end
  end

end
