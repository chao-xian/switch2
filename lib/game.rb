# frozen_string_literal: true

class Game
  def initialize(name:, link:, added_at:, platform:, format: nil, rating: nil)
    @name = name
    @link = link
    @added_at = added_at
    @format = format
    @rating = rating
    @platform = platform
    @compatible = false
  end

  attr_accessor :name, :link, :added_at, :format, :rating, :platform, :compatible
end

