require "cgi"

class NintendoCompatibilityChecker
  BASE_URI = "https://switch-software-compatibility.nintendo.com"
  SEARCH_PATH = "/en-GB/search?q="

  def initialize(game)
    @game = game
  end

  # Returns true/false once a details page is found, or nil if the game
  # doesn't appear in Nintendo's compatibility search at all.
  def call
    details_link = find_details_link
    return nil unless details_link

    page = fetch(details_link)
    supported = page.css('span:contains("Supported")').any?
    unsupported = page.css('span:contains("Unsupported")').any?

    supported && !unsupported
  end

  private

  attr_reader :game

  def find_details_link
    query = CGI.escape(game.name)
    results_page = fetch("#{SEARCH_PATH}#{query}")
    link = results_page.at_xpath('//a[contains(@href, "/en-GB/details")]')
    link && link["href"]
  end

  def fetch(path)
    response = HTTParty.get("#{BASE_URI}#{path}")
    Nokogiri::HTML(response.body)
  end
end
