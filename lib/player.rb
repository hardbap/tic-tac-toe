class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def make_move(available_squares)
    available_squares.sample
  end
end
