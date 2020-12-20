# frozen_string_literal: true

# Responsible for creating offers
class Matches::MatchesIntr < ApplicationInteraction
  def execute
    League.all.each do |league|
      begin
        Matches::CreateIntr.run!(league_id: league.league_ssid)
      rescue
        next
      end
    end
  end
end