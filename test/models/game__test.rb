require "test_helper"

class GameTest < ActiveSupport::TestCase
  def setup
    @game = games(:game_one)
  end

  test 'year_game column' do
    assert Game.column_names.include?('year_game') 

    assert_equal 'integer', Game.column_for_attribute(:year_game).type.to_s, 'Correct name type'
  end

  test 'has_one :worker_without_a_pair relation' do 
    worker = worker_without_a_pairs(:worker_one)

    assert_equal worker, @game.worker_without_a_pair, 'relation between worker and location'
  end

  test 'has_many :couples relation' do 
    couple = couples(:couple_one)

    assert_equal couple, @game.couples.first, 'relation between worker and location'
  end

  test 'invalid without year_game' do
    @game.year_game = nil

    refute @game.valid?
    assert @game.errors[:year_game].present?, 'error without year_game'
  end

  test 'valid with year_game' do
    @game.year_game = 2023

    assert @game.valid?
  end

  test 'invalid year range' do
    @game.year_game = 2022

    refute @game.valid?
    assert @game.errors[:year_game].present?, 'error without year_game'
  end

  test 'valid year range' do
    @game.year_game = 2023

    assert @game.valid?
  end
end
