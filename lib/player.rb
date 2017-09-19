class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def make_move(available_squares)
    sleep(Random.rand(3) + 1) # have it appear that AI is thinking about it ;-P
    # Keep our AI super simple for now.
    available_squares.sample
  end
end
