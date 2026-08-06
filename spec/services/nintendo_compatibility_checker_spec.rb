require "rails_helper"

RSpec.describe NintendoCompatibilityChecker do
  let(:game) { build(:game, name: "A Short Hike") }

  def stub_search(html)
    stub_request(:get, "https://switch-software-compatibility.nintendo.com/en-GB/search?q=A+Short+Hike")
      .to_return(body: html)
  end

  def stub_details(html)
    stub_request(:get, "https://switch-software-compatibility.nintendo.com/en-GB/details/a-short-hike")
      .to_return(body: html)
  end

  it "returns true when the details page shows Supported without Unsupported" do
    stub_search('<a href="/en-GB/details/a-short-hike">A Short Hike</a>')
    stub_details('<span>Supported</span>')

    expect(described_class.new(game).call).to eq(true)
  end

  it "returns false when the details page shows Unsupported" do
    stub_search('<a href="/en-GB/details/a-short-hike">A Short Hike</a>')
    stub_details('<span>Supported</span><span>Unsupported</span>')

    expect(described_class.new(game).call).to eq(false)
  end

  it "returns nil when the game isn't found in search results" do
    stub_search('<p>No results found</p>')

    expect(described_class.new(game).call).to be_nil
  end
end
