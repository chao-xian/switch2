require "rails_helper"

RSpec.describe Game do
  it "is valid with a name, link, and platform" do
    expect(build(:game)).to be_valid
  end

  it "requires a name" do
    expect(build(:game, name: nil)).not_to be_valid
  end

  it "requires a link" do
    expect(build(:game, link: nil)).not_to be_valid
  end

  it "requires a platform" do
    expect(build(:game, platform: nil)).not_to be_valid
  end

  it "requires a unique link" do
    create(:game, link: "https://www.dekudeals.com/items/duplicate")

    duplicate = build(:game, link: "https://www.dekudeals.com/items/duplicate")

    expect(duplicate).not_to be_valid
  end

  it "rejects a link with an unsafe scheme" do
    expect(build(:game, link: "javascript:alert(1)")).not_to be_valid
  end

  it "defaults to not compatible" do
    expect(Game.new.compatible).to eq(false)
  end
end
