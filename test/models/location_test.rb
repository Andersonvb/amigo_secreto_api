require "test_helper"

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = locations(:location_one)
  end

  test 'name column' do
    assert Location.column_names.include?('name') 

    assert_equal 'string', Location.column_for_attribute(:name).type.to_s, 'Correct name type'
  end

  test 'has_many :workers relation' do
    worker = workers(:worker_one)

    assert_equal @location, worker.location, 'relation between worker and location'
  end

  test 'invalid without name' do
    @location.name = nil

    refute @location.valid?
    assert @location.errors[:name].present?, 'error without name'
  end

  test 'valid with name' do
    assert @location.valid?
  end
  
  test 'invalid name length' do
    @location.name = 'An'

    refute @location.valid?
    assert @location.errors[:name].present?, 'error with too short name'
  end

  test 'valid name length' do
    @location.name = 'And'

    assert @location.valid?
  end

  test 'invalid name with unsafe characters' do
    @location.name = 'An*#%n'

    refute @location.valid?
    assert @location.errors[:name].present?, 'error name with unsafe characters'
  end
end
