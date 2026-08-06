namespace :games do
  desc "Import games from data/collection.json"
  task import: :environment do
    data = JSON.load_file(Rails.root.join("data/collection.json"))

    data["items"].each do |attrs|
      game = Game.find_or_initialize_by(link: attrs["link"])
      game.assign_attributes(attrs.slice("name", "added_at", "format", "rating", "platform"))
      game.save!
    end

    puts "Imported #{Game.count} games."
  end
end
