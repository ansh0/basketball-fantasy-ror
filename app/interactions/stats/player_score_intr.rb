# frozen_string_literal: true

# Responsible for creating offers
class Stats::PlayerScoreIntr < ApplicationInteraction

  hash :match_stats, strip: false

  validates :match_stats, presence: true

  def execute
    PlayerStat.import get_player_stats_data, on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
  	[
      :location,
      :play_time,
      :shoot_hit,
      :shooot,
      :three_point_hit,
      :three_point_shoot,
      :penalty_shot_hit,
      :penalty_shot,
      :attack,
      :foul,
      :rob,
      :miss,
      :cover,
      :score,
      :on_floor
    ]
  end

  def selector
    [:team_id, :match_id, :player_id]
  end

  def get_player_stats_data
  	match_stats.each_with_object([]) do |match_stat, data|
      home_team_id = team_by_name(match_stat["homeTeamName"])
      away_team_id = team_by_name(match_stat["awayTeamName"])
      match_id = match_by_ssid(match_stat["matchId"])
      match_stat["home_players"].each do |player|
        data << extract_player_score(match_id, home_team_id, player)
      end
      match_stat["awayPlayers"].each do |player|
        data << extract_player_score(match_id, away_team_id, player)
      end
  	end
  end

  def extract_player_score(match_id, team_id, player)
  	match_stat.tap do |data|
  		data[:team_id] = team_id
  		data[:match_id] = match_id
      data[:player_id] = player_by_ssid(player["playerId"])
      data[:location] = player["location"]
      data[:play_time] = player["playingTime"]
      data[:shoot_hit] = player["shootHit"]
      data[:shooot] = player["shoot"]
      data[:three_point_hit] = player["threePointHit"]
      data[:three_point_shoot] = player["threePointShot"]
      data[:penalty_shot_hit] = player["penaltyShotHit"]
      data[:penalty_shot] = player["penaltyShot"]
      data[:attack] = player["attack"]
      data[:foul] = player["foul"]
      data[:rob] = player["rob"]
      data[:miss] = player["miss"]
      data[:cover] = player["cover"]
      data[:score] = player["score"]
      data[:on_floor] = player["onFloor"]
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

  def players
    @players ||= Player.all.to_a
  end

  def player_by_ssid(ssid)
    player = players.find{|b| b.player_ssid == ssid}
    player.id
  end
end

