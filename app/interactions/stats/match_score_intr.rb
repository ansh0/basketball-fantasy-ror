# frozen_string_literal: true

# Responsible for creating offers
class Stats::MatchScoreIntr < ApplicationInteraction
  hash :match_stats, strip: false

  validates :match_stats, presence: true

  def execute
    MatchStat.import get_match_stats_data, on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
  	[
      :home_score,
      :away_score,
      :home_total_miss,
      :away_total_miss
    ]
  end

  def selector
    [:home_team_id, :away_team_id, :match_id]
  end

  def get_match_stats_data
  	match_stats.each_with_object([]) do |match_stat, data|
  		data << extract_match_score(match_stat)
  	end
  end

  def extract_match_score(match_stat)
  	{}.tap do |data|
  		data[:home_team_id] = team_by_name(match_stat["homeTeamName"])
  		data[:away_team_id] = team_by_name(match_stat["awayTeamName"])
  		data[:match_id] = match_by_ssid(match_stat["matchId"])
  		data[:home_score] = match_stat["homeScore"]
  		data[:away_score] = match_stat["awayScore"]
  		data[:home_total_miss] = match_stat["homeTotalMiss"]
  		data[:away_total_miss] = league_by_ssid(match_stat["awayTotalMiss"])
  	end
  end

  def teams
  	@teams ||= Team.all.to_a
  end

  def team_by_name(name)
    team = teams.find{|b| b.name == name}
    team.id
  end

  def matches
    @matches ||= Match.all.to_a
  end

  def match_by_ssid(ssid)
    matche = matches.find{|b| b.match_ssid == ssid}
    matche.id
  end
end

