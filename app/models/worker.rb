class Worker < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }, format: { with: /\A[a-zA-Z0-9_]+(?: [a-zA-Z0-9_]+)*\z/ }
  validates :location, presence: true

  belongs_to :location

  has_many :couple_as_first_worker, foreign_key: 'first_worker_id', class_name: 'Couple', dependent: :destroy
  has_many :couple_as_second_worker, foreign_key: 'second_worker_id', class_name: 'Couple', dependent: :destroy
end
