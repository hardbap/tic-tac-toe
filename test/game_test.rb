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

  end
end
