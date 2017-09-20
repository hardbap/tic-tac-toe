require_relative './test_helper'
require_relative '../lib/hostess'

class HostessTest < Minitest::Test

  def setup
    @hostess = Hostess.new
  end

  def test_it_will_start_a_game_with_good_selection
    @hostess.expects(:ask).with('Which player do you want to be? X or O: ').returns('X')
    @hostess.expects(:notify)
    @hostess.expects(:play).with('X')

    @hostess.start
  end


  def test_it_will_not_start_a_game_with_bad_selection
    @hostess.expects(:ask).with('Which player do you want to be? X or O: ').returns('X')
    @hostess.expects(:notify)
    @hostess.expects(:play).with('X')

    @hostess.expects(:ask).with('Which player do you want to be? X or O: ').returns('1')
    @hostess.expects(:uhoh)

    @hostess.start
  end
end
