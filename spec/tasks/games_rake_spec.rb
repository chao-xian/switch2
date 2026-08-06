require "rails_helper"
require "rake"

RSpec.describe "games rake tasks" do
  before(:all) do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  before do
    Rake::Task["games:check_compatibility"].reenable
  end

  describe "games:check_compatibility" do
    it "queues a compatibility check job for every game" do
      games = create_list(:game, 2)

      expect { Rake::Task["games:check_compatibility"].invoke }
        .to have_enqueued_job(CheckCompatibilityJob).with(games.first)
        .and have_enqueued_job(CheckCompatibilityJob).with(games.second)
    end
  end
end
