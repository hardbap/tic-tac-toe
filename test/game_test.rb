require_relative './test_helper'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new('X')
  end

  def test_it_will_have_all_win_conditions
    assert_equal 8, @game.win_conditions.size
  end

  def test_it_will_have_row_win_conditions
    rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ]

    rows.each do |row|
      assert_includes @game.win_conditions, row, "Row #{row} missing from win conditions"
    end
  end

  def test_it_will_have_column_win_conditions
    columns = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
    ]

    columns.each do |column|
      assert_includes @game.win_conditions, column, "Column #{column} missing from win conditions"
    end
  end

  def test_it_will_have_diagonal_win_conditions
    diagonals = [
      [0, 4, 8],
      [2, 4, 6],
    ]

    diagonals.each do |diagonal|
      assert_includes @game.win_conditions, diagonal, "Diagonal #{diagonal} missing from win conditions"
    end
  end

  def test_it_will_give_us_the_win_conditions_for_a_square
    expected = [
      [0, 1, 2],
      [2, 5, 8],
      [2, 4, 6],
    ]

    assert_equal expected, @game.win_conditions_for_square(2)
  end

  def test_it_will_know_when_game_is_won
    board = Board.new

    (1..9).each { |n| board.set(n, n.even? ? 'X' : 'O')}

    oh_wins_game = Game.new('X', board)

    assert oh_wins_game.game_is_won?(3, 'O'), '"O" wins on the 2 diagonal'
    assert oh_wins_game.game_is_won?(1, 'O'), '"O" wins on the 0 diagonal'
    refute oh_wins_game.game_is_won?(2, 'X'), '"X" does not win this game'
  end

  def test_it_will_know_when_game_is_a_draw
    stale_board = Board.new

    x_moves = [1,3,5,6,8]
    o_moves = [2,4,7,9]

    x_moves.each { |n| stale_board.set(n, 'X') }
    o_moves.each { |n| stale_board.set(n, 'O') }

    stale_game = Game.new('X', stale_board)

    assert stale_game.game_is_a_draw?
  end

  def test_it_will_know_when_it_is_a_legal
    @game.log_human_move(1)
    @game.log_ai_move(2)
    @game.log_human_move(3)
    @game.log_ai_move(4)

    refute @game.legal_game?

    @game.log_human_move(5)

    assert @game.legal_game?
  end

  def test_it_will_know_the_last_mark_placed
    @game.human_move(5)

    assert_equal 'X', @game.last_mark_placed
  end

  def test_it_will_log_the_AI_move
    @game.log_ai_move(9)

    assert_equal [9, 'O'], @game.last_move
  end

  def test_it_will_log_human_move
    @game.log_human_move(1)

    assert_equal [1, 'X'], @game.last_move
  end

  def test_it_will_know_the_last_move
    @game.log_human_move(1)
    @game.log_ai_move(9)

    assert_equal [9, 'O'], @game.last_move
  end

  def test_it_will_know_the_number_of_turns_taken
    @game.log_human_move(1)
    @game.log_ai_move(9)

    assert_equal 2, @game.turn_number
  end

  def test_it_will_expose_the_boards_squares
    board = Board.new

    (1..9).each { |n| board.set(n, n.even? ? 'X' : 'O')}

    oh_wins_game = Game.new('X', board)

    assert_equal board.squares, oh_wins_game.play_area
  end

  def test_it_will_assign_other_mark_to_AI
    assert_equal 'O', Game.new('X').computer_player.mark, 'AI should be "O"'
    assert_equal 'X', Game.new('O').computer_player.mark, 'AI should be "X"'
  end
end
