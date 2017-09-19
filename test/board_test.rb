require_relative './test_helper'
require_relative '../lib/board'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_will_have_nine_squares
    assert_equal 9, @board.squares.size
  end

  def test_it_will_return_nil_when_square_is_filled
    @board.set(2, 'X')

    refute @board.set(2, 'O')
  end

  def test_it_will_return_minus_one_for_bad_square
    assert_equal Integer(-1), @board.set(10, 'X'), '10 is an invalid square'
    assert_equal Integer(-1), @board.set(0, 'X'), '0 is an invalid square'
  end

  def test_it_will_set_a_value
    @board.set(2, 'X')

    assert_equal 'X', @board.squares[1]
  end
end
