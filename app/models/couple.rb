class Couple < ApplicationRecord
  validates :game, presence: true
  validates :first_worker, presence: true
  validates :second_worker, presence: true

  belongs_to :game
  belongs_to :first_worker, class_name: 'Worker'
  belongs_to :second_worker, class_name: 'Worker'
end
