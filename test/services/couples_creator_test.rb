require 'test_helper'
require_relative '../../app/services/couples_creator.rb'

class CouplesCreatorTest < ActiveSupport::TestCase
  def setup
    @game = Game.create(year_game: 2024)
    Couple.destroy_all
  end

  test 'Create couples successfully' do
    couples_created = CouplesCreator.call(@game)

    assert couples_created
    assert_equal (Worker.all.size / 2).floor, couples_created.size, 'Correct number of couples'
  end

  test 'Not possible couples' do
    workers(:worker_three).destroy
    
    new_game = Game.create(year_game: 2025)

    assert CouplesCreator.call(@game)
    refute CouplesCreator.call(new_game)
  end
end
