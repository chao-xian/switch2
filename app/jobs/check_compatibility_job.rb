class CheckCompatibilityJob < ApplicationJob
  queue_as :default

  def perform(game)
    result = NintendoCompatibilityChecker.new(game).call
    game.update!(compatible: result.nil? ? false : result)
  end
end
