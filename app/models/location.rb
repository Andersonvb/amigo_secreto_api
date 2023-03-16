class Location < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 },
                   format: { with: /\A[a-zA-Z0-9_]+(?: [a-zA-Z0-9_]+)*\z/ }

  has_many :workers, dependent: :destroy
end
