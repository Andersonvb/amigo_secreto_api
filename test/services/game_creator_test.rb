require 'test_helper'
require_relative '../../app/services/game_creator.rb'

class GameCreatorTest < ActiveSupport::TestCase
  include GameCreatorAsserts

  def setup
    Game.destroy_all
    @game = Game.new(year_game: 2024)
  end

  test 'game is created successfully' do
    game_creator_asserts(@game)
  end

  test 'game creation with invalid year' do
    @game.year_game = 2019

    game_creator_failing_asserts(@game)
  end

  test 'repeated year' do
    new_game = @game.clone

    game_creator_asserts(@game)
    game_creator_failing_asserts(new_game)

  end

  test 'game creation in a year without possible couples' do 
    workers(:worker_three).destroy
    workers(:worker_four).destroy

    new_game = Game.new(year_game: 2025)

    game_creator_asserts(@game)
    game_creator_failing_asserts(new_game)
  end
end