require 'test_helper'
require_relative '../../app/services/couples_creator.rb'

class CouplesCreatorTest < ActiveSupport::TestCase
  def setup
    @game = games(:game_one)
    Couple.destroy_all
  end

  test 'Create couples ssuccessfully' do
    couples_created = CouplesCreator.call(@game)

    assert couples_created
    assert_equal (Worker.all.size / 2).floor, couples_created.size, 'Correct number of couples'
  end

  test 'Not possible couples' do
    Worker.last.destroy
    
    game_two = Game.create(year_game: 2024)

    CouplesCreator.call(@game)

    refute CouplesCreator.call(game_two)
  end
end
