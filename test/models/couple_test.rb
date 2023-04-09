require "test_helper"

class CoupleTest < ActiveSupport::TestCase
  def setup
    @couple = couples(:couple_one)
  end

  test 'game column' do
    assert Couple.column_names.include?('game_id') 

    assert_equal 'integer', Couple.column_for_attribute(:game_id).type.to_s, 'Correct name type'
  end

  test 'first_worker_id column' do
    assert Couple.column_names.include?('first_worker_id') 

    assert_equal 'integer', Couple.column_for_attribute(:first_worker_id).type.to_s, 'Correct name type'
  end

  test 'second_worker_id column' do
    assert Couple.column_names.include?('second_worker_id') 

    assert_equal 'integer', Couple.column_for_attribute(:second_worker_id).type.to_s, 'Correct name type'
  end

  test 'belongs_to :game relation' do
    game = games(:game_one)

    assert_equal game, @couple.game, 'relation between couple and game'
  end

  test 'belongs_to :first_worker relation' do
    worker_one = workers(:worker_one)

    assert_equal worker_one, @couple.first_worker, 'relation between couple and game'
  end

  test 'belongs_to :second_worker relation' do
    worker_two = workers(:worker_two)

    assert_equal worker_two, @couple.second_worker, 'relation between couple and game'
  end

  test 'couple indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Couple.table_name)
    game_id_index = indexes.find { |index| index.columns == ['game_id'] }
    first_worker_id_index = indexes.find { |index| index.columns == ['first_worker_id'] }
    second_worker_id_index = indexes.find { |index| index.columns == ['second_worker_id'] }

    assert game_id_index.present?
    assert first_worker_id_index.present?
    assert second_worker_id_index.present?
  end

  test 'invalid without game' do
    @couple.game = nil

    refute @couple.valid?
    assert @couple.errors[:game].present?
  end

  test 'invalid without first worker' do
    @couple.first_worker = nil

    refute @couple.valid?
    assert @couple.errors[:first_worker].present?
  end

  test 'invalid without second worker' do
    @couple.second_worker = nil

    refute @couple.valid?
    assert @couple.errors[:second_worker].present?
  end

  test 'valid couple' do
    assert @couple.valid?
  end
end
