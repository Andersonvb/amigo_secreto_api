require 'test_helper'
require_relative '../../app/services/game_creator.rb'

class GameCreatorTest < ActiveSupport::TestCase
  def setup
    @game = Game.new(year_game: 2024)
  end

  test 'Game is created successfully' do
    assert GameCreator.call(@game)
    assert @game.persisted?
  end

  test 'Game creation with invalid year' do
    @game.year_game = 2019

    refute GameCreator.call(@game)
    refute @game.persisted?
  end

  test 'Repeated year' do
    new_game = @game.clone

    assert GameCreator.call(@game)    
    assert @game.persisted?
    refute GameCreator.call(new_game)
    refute new_game.persisted?
  end

  test 'Game creation in a year without possible couples' do 
    Worker.last.destroy

    new_game = Game.new(year_game: 2025)

    assert GameCreator.call(@game)
    assert @game.persisted?
    #GameCreator.call(new_game)
  end
end