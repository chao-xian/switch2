FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "Game #{n}" }
    sequence(:link) { |n| "https://www.dekudeals.com/items/game-#{n}" }
    added_at { Time.current }
    format { "digital" }
    rating { 4 }
    platform { "Switch" }
    compatible { false }
  end
end
