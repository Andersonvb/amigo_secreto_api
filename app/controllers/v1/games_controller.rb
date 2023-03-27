require_relative '../../services/couples_creator_service'

class V1::GamesController < ApplicationController
  def index
    @games = Game.order(:year_game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      if CouplesCreator.call(@game)
        render :create, status: :created
      else
        @game.errors.add(:base, I18n.t('activerecord.errors.models.game.base.couples_not_possible'))
        render 'errors/error', locals: { object: @game }, formats: :json
        @game.destroy
      end
    else
      render 'errors/error', locals: { object: @game }, formats: :json
    end
  end

  private

  def game_params
    params.require(:game).permit(:year_game)
  end
end
