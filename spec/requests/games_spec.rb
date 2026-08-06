require "rails_helper"

RSpec.describe "Games" do
  describe "GET /games" do
    it "lists the games" do
      create(:game, name: "A Short Hike")

      get games_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("A Short Hike")
    end
  end

  describe "GET /games/:id" do
    it "shows the game" do
      game = create(:game, name: "A Short Hike")

      get game_path(game)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("A Short Hike")
    end
  end

  describe "POST /games/:id/check_compatibility" do
    it "queues a compatibility check job" do
      game = create(:game)

      expect { post check_compatibility_game_path(game) }
        .to have_enqueued_job(CheckCompatibilityJob).with(game)

      expect(response).to redirect_to(game_path(game))
    end
  end

  describe "POST /games/check_compatibility" do
    it "queues a compatibility check job for every game" do
      games = create_list(:game, 2)

      expect { post check_all_compatibility_games_path }
        .to have_enqueued_job(CheckCompatibilityJob).with(games.first)
        .and have_enqueued_job(CheckCompatibilityJob).with(games.second)

      expect(response).to redirect_to(games_path)
    end
  end
end
