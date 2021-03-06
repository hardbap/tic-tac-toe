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

  def test_it_will_know_when_full
    @board.set(1, 'O')

    refute @board.full?, 'Board is not full'

    (2..9).each { |n| @board.set(n, n.even? ? 'X' : 'O')}

    assert @board.full?, 'Board is full'
  end

  def test_it_will_not_set_bad_mark
    assert_equal Integer(-2), @board.set(1, '0')
  end

  def test_it_will_return_minus_one_for_bad_square
    assert_equal Integer(-1), @board.set(10, 'X'), '10 is an invalid square'
    assert_equal Integer(-1), @board.set(0, 'X'), '0 is an invalid square'
  end

  def test_it_will_set_a_value
    @board.set(2, 'X')

    assert_equal 'X', @board.squares[1]
  end

  def test_it_will_know_the_available_squares
    (2..9).each { |n| @board.set(n, n.even? ? 'X' : 'O')}

    assert_equal [1], @board.available_squares
  end

  def test_it_will_reset_itself
    empty_board = Array(1..9)
    empty_board.each { |n| @board.set(n, n.even? ? 'X' : 'O')}
    @board.reset
    assert_equal empty_board, @board.squares
  end
end
