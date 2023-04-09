require 'test_helper'
require_relative '../../app/services/couples_creator.rb'

class CouplesCreatorTest < ActiveSupport::TestCase
  include CouplesCreatorAsserts

  def setup
    Game.destroy_all
    Couple.destroy_all
    WorkerWithoutAPair.destroy_all
  end

  test 'should create couples successfully with even number of workers' do
    game = Game.create(year_game: 2024)

    couples_creator_asserts(game)
  end

  test 'should create couples successfully with odd number of workers' do
    workers(:worker_four).destroy
    
    game = Game.create(year_game: 2024)

    couples_creator_asserts(game)
  end

  test 'should create multiple game couples successfully' do
    first_game = Game.create(year_game: 2024) 
    second_game = Game.create(year_game: 2025)
    third_game = Game.create(year_game: 2026) 
    fourth_game = Game.create(year_game: 2027)

    couples_creator_asserts(first_game)
    couples_creator_asserts(second_game)
    couples_creator_asserts(third_game)
    couples_creator_asserts(fourth_game)
  end

  test 'not possible to create couples with only one worker' do
    workers(:worker_two).destroy
    workers(:worker_three).destroy
    workers(:worker_four).destroy
    
    game = Game.create(year_game: 2024) 

    couples_creator_failing_asserts(game)
  end

  test 'not possible to create two game couples in a row with only two workers (not possible combinations)' do
    workers(:worker_three).destroy
    workers(:worker_four).destroy
    
    first_game = Game.create(year_game: 2024) 
    second_game = Game.create(year_game: 2025)

    couples_creator_asserts(first_game)
    couples_creator_failing_asserts(second_game)
  end
end
