class WorkerWithoutAPair < ApplicationRecord
  validates :game, presence: true
  validates :worker, presence: true

  belongs_to :game
  belongs_to :worker
end
