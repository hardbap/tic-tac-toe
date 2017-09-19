require_relative './tools'

class Board
  include Tools

  attr_reader :squares

  def initialize
    reset
  end

  def set(square_number, mark)
    return -1 unless (1..9).include?(square_number)
    return -2 unless check_value(mark)

    index = normalize_square_number(square_number)
    return nil if check_value(squares[index])

    @squares[index] = mark
  end

  def full?
    @squares.all?(&method(:check_value))
  end

  def available_squares
    @squares.select { |val| !check_value(val) }
  end

  def reset
    @squares = Array(1..9)
  end


end
