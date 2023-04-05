require_relative './application_service'
require_relative './couples_creator'

class GameCreator < ApplicationService
  def initialize(game)
    @game = game
  end

  def call
    save_game(@game) 
  end

  private

  def save_game(game)
    if game.save && CouplesCreator.call(game)
      true
    else
      game.errors.add(:base, I18n.t('activerecord.errors.models.game.base.couples_not_possible'))
      game.destroy
      false
    end
  end
end
