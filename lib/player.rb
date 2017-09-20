class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def make_move(available_squares)
    # have it appear that AI is thinking about it ;-P
    sleep(Random.rand(2) + 1) unless ENV.fetch('SKIP_AI', false)
    # Keep our AI super simple for now.
    available_squares.sample
  end
end
