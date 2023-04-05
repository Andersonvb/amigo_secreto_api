require_relative '../../services/couples_creator'

class V1::GamesController < ApplicationController
  def index
    @games = Game.order(:year_game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if GameCreator.call(@game)
      render :create, status: :created
    else
      render 'errors/error', locals: { object: @game }, formats: :json, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:year_game)
  end
end
