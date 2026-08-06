class GamesController < ApplicationController
  def index
    @games = Game.order(:name)
  end

  def show
    @game = Game.find(params[:id])
  end

  def check_compatibility
    game = Game.find(params[:id])
    CheckCompatibilityJob.perform_later(game)
    redirect_to game, notice: "Compatibility check queued."
  end
end
