class Couple < ApplicationRecord
  belongs_to :game
  belongs_to :first_worker, class_name: 'Worker'
  belongs_to :second_worker, class_name: 'Worker'
end
