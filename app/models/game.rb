class Game < ApplicationRecord
  validates :name, :link, :platform, presence: true
  validates :link, uniqueness: true
end
