require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  def setup
    @worker_one = workers(:worker_one)
    @worker_two = workers(:worker_two)
  end

  # DB
  test 'name column' do
    assert Worker.column_names.include?('name') 

    assert_equal 'string', Worker.column_for_attribute(:name).type.to_s, 'Correct name type'
  end

  # Associations
  test 'belongs_to :location relation' do
    location = locations(:location_one)

    assert_equal location, @worker_one.location, 'relation between worker and location'
  end

  test 'has_many :couples_as_first_worker relation' do
    couple = couples(:couple_one)

    assert_equal couple, @worker_one.couples_as_first_worker.first, 'relation between worker and couple'
  end

  test 'has_many :workers_without_a_pair relation' do
    worker_without_a_pair = worker_without_a_pairs(:worker_one)

    assert_equal worker_without_a_pair, @worker_one.worker_without_a_pairs.first, 'relation between worker and couple'
  end

  # Validations
  
  test 'invalid without name' do
    @worker_one.name = nil

    refute @worker_one.valid?
    assert @worker_one.errors[:name].present?, 'error without name'
  end

  test 'invalid name length' do
    @worker_one.name = 'An'

    refute @worker_one.valid?
    assert @worker_one.errors[:name].present?, 'error with too short name'
  end

  test 'invalid name with unsafe characters' do
    @worker_one.name = 'An$%^'

    refute @worker_one.valid?
    assert @worker_one.errors[:name].present?, 'error with unsafe characters'
  end

  test 'invalidad without location' do
    @worker_one.location = nil

    refute @worker_one.valid?
    assert @worker_one.errors[:location].present?, 'error without location'
  end
end
