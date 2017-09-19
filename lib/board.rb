class Board
  attr_reader :squares

  def initialize()
    @squares = Array(1..9)
  end

  def set(square_number, value)
    return -1 unless (1..9).include?(square_number)
    return -2 unless check_value(value)

    index = normalize_square_number(square_number)
    return nil if check_value(squares[index])

    @squares[index] = value
  end

  def full?
    @squares.all?(&method(:check_value))
  end

  def normalize_square_number(number)
    number - 1
  end

  def check_value(val)
    %w(X O).include?(val)
  end

  def draw
    sep = "\t+---+---+---+\n"
    puts sep

    @squares.each_slice(3).each do |slice|
      puts "\t| #{slice.join(' | ')} |"
      puts sep
    end
  end
end
