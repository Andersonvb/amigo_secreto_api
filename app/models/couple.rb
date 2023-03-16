class Couple < ApplicationRecord
  validate :different_workers

  belongs_to :game
  belongs_to :first_worker, class_name: 'Worker'
  belongs_to :second_worker, class_name: 'Worker'

  private

  def different_workers
    errors.add(:second_worker, 'Un empleado no puede ser su misma pareja') if first_worker == second_worker
  end
end
