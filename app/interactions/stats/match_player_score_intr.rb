# frozen_string_literal: true

# Responsible for creating offers
class Stats::MatchPlayerScoreIntr < ApplicationInteraction
  def execute
    @scores = get_scorings
    Stats::MatchScoreIntr.run!(match_stats: @scores)
    Stats::PlayerScoreIntr.run!(match_stats: @scores)
  end

  def get_scorings
    res = EsportBaseIntr.run(url_type: 'stats')
    res.result["data"]
  end
end

