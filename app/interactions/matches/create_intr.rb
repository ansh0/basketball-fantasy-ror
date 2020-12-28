# frozen_string_literal: true

# Responsible for creating offers
class Matches::CreateIntr < ApplicationInteraction
  string :league_ssid

  validates :league_ssid, presence: true

  def execute
    @matches = get_matches
    Match.import get_matches_data(@matches), on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
    [
      :match_timestamp,
      :status,
      :home_name,
      :away_name,
      :home_score,
      :away_score,
      :explain_status,
      :neutral,
      :home_team_id,
      :away_team_id
    ]
  end

  def selector
    [:match_ssid, :league_id]
  end

  def get_matches_data(matches)
    matches.each_with_object([]) do |match_obj, data|
      begin
        data << extract_match_obj(match_obj)
      rescue
        next
      end
    end
  end

  def extract_match_obj(match_obj)
    match_obj.tap do |data|
      data[:match_ssid] = match_obj["matchId"]
      data[:league_id] = match_obj["leagueId"]
      data[:match_timestamp] = Time.at(match_obj["matchTime"]).to_datetime
      data[:status] = match_obj["status"]
      data[:home_name] = match_obj["homeName"]
      data[:away_name] = match_obj["awayName"]
      data[:home_score] = match_obj["homeScore"]
      data[:away_score] = match_obj["awayScore"]
      data[:explain_status] = match_obj["explain"]
      data[:neutral] = match_obj["neutral"]
      data[:home_team_id] = team_by_name(match_obj["homeName"])
      data[:away_team_id] = team_by_name(match_obj["awayName"])
    end
  end

  def teams
    @teams ||= Team.all.to_a
  end

  def team_by_name(name)
    team = teams.find{|b| b.name == name}
    team.id
  end

  def get_matches
    res = EsportBaseIntr.run(url_type: 'schedule/basic', data_params: {leagueId: league_ssid})
    res.result["data"]
  end
end