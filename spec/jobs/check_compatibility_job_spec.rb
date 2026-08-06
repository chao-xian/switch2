require "rails_helper"

RSpec.describe CheckCompatibilityJob do
  it "marks the game compatible when the checker returns true" do
    game = create(:game, compatible: false)
    allow_any_instance_of(NintendoCompatibilityChecker).to receive(:call).and_return(true)

    described_class.perform_now(game)

    expect(game.reload.compatible).to eq(true)
  end

  it "marks the game not compatible when the checker can't find it" do
    game = create(:game, compatible: true)
    allow_any_instance_of(NintendoCompatibilityChecker).to receive(:call).and_return(nil)

    described_class.perform_now(game)

    expect(game.reload.compatible).to eq(false)
  end
end
