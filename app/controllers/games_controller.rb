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

  def check_all_compatibility
    Game.find_each do |game|
      CheckCompatibilityJob.perform_later(game)
    end

    redirect_to games_path, notice: "Compatibility checks queued for #{Game.count} games."
  end
end
