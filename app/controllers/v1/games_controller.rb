class V1::GamesController < ApplicationController
  def index
    @games = Game.all
    @couples = Couple.all
    @workers_without_a_pair = WorkerWithoutAPair.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      render @game
    else
      render 'errors/error', locals: { object: @game }, formats: :json
    end
  end

  private

  def game_params
    params.require(:game).permit(:year_game)
  end
end
