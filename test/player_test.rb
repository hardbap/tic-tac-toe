require_relative './test_helper'
require_relative '../lib/player'

class PlayerTest < Minitest::Test

  def test_AI_will_make_a_move
    player = Player.new('Player 1', 'X')
    available_squares = [1, 2, 3]
    
    assert_includes available_squares, player.make_move(available_squares)
  end
end
