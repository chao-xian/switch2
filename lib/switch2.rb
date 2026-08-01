require "bundler/setup"
require "httparty"
require "json"
require "nokogiri"

require_relative "game"

data = JSON.load_file("data/collection.json")

games = []

data["items"].each do |d|
  game = Game.new(**d.transform_keys(&:to_sym))
  games << game
end

pp "You have #{games.length} games."

base_uri = "https://switch-software-compatibility.nintendo.com/en-GB/search?q="

i = 0

games.each do |game|
  q = CGI.escape(game.name)
  result =  HTTParty.get("#{base_uri}#{q}")
  doc = Nokogiri::HTML(result.body)

  if doc.xpath('//a[contains(@href, "/en-GB/details")]')
    i += 1
    game.compatible = true
    pp "#{game.name}: #{game.compatible}"
  end

  # goto the details page
  # check that the word supported exists
  # AND the word UNSUPPORTED isn't on the page
  # example "A Long Way Down" is unsupported

end

pp "#{i} games are compatible"
