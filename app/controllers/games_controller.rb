class GamesController < ApplicationController
  def index
    @games = Game.order(:name)
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game, notice: "Game updated."
    else
      render :edit, status: :unprocessable_content
    end
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

  private

  def game_params
    params.expect(game: [ :name, :link, :added_at, :format, :rating, :platform, :compatible ])
  end
end
