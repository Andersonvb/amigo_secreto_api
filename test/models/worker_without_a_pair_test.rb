require "test_helper"

class WorkerWithoutAPairTest < ActiveSupport::TestCase
  def setup
    @worker_without_pair = worker_without_a_pairs(:worker_one)
  end

  test 'game_id column' do
    assert WorkerWithoutAPair.column_names.include?('game_id') 

    assert_equal 'integer', WorkerWithoutAPair.column_for_attribute(:game_id).type.to_s, 'Correct name type'
  end

  test 'worker_id column' do
    assert WorkerWithoutAPair.column_names.include?('worker_id') 

    assert_equal 'integer', WorkerWithoutAPair.column_for_attribute(:worker_id).type.to_s, 'Correct name type'
  end

  test 'belongs_to :game relation' do
    game = games(:game_one)

    assert_equal game, @worker_without_pair.game
  end

  test 'belongs_to :worker relation' do
    worker = workers(:worker_three)

    assert_equal worker, @worker_without_pair.worker
  end

  test 'worker_without_a_pair indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(WorkerWithoutAPair.table_name)
    game_id_index = indexes.find { |index| index.columns == ['game_id'] }
    worker_id_index = indexes.find { |index| index.columns == ['worker_id'] }

    assert game_id_index.present?
    assert worker_id_index.present?
  end

  test 'invalid without game' do
    @worker_without_pair.game = nil

    refute @worker_without_pair.valid?
    assert @worker_without_pair.errors[:game].present?, 'error without game'
  end

  test 'invalid without worker' do
    @worker_without_pair.worker = nil

    refute @worker_without_pair.valid?
    assert @worker_without_pair.errors[:worker].present?, 'error without game'
  end
end
