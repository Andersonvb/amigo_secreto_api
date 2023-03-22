class Game < ApplicationRecord
  validates :year_game, presence: true, uniqueness: true, inclusion: { in: (2023..2032) }
  validate :two_or_more_workers

  has_one :worker_without_a_pair, dependent: :destroy

  has_many :couples, dependent: :destroy

  private

  def two_or_more_workers
    errors.add(:base, I18n.t('activerecord.errors.models.game.base.two_or_more_workers')) if Worker.count < 2
  end
end
