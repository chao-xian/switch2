class Game < ApplicationRecord
  LINK_FORMAT = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/

  validates :name, :link, :platform, presence: true
  validates :link, uniqueness: true, format: { with: LINK_FORMAT, message: "must be a valid http(s) URL" }
end
