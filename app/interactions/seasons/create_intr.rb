# frozen_string_literal: true

# Responsible for creating offers
class Seasons::CreateIntr < ApplicationInteraction
  def execute
    @seasons = get_seasons
    Season.import get_seasons_data(@seasons), on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
  	[:name, :season_name, :group_count, :round_count, :sort_number, :current_group, :group]
  end

  def selector
    [:season_ssid, :league_id]
  end

  def get_seasons_data(seasons)
  	seasons.each_with_object([]) do |season, data|
  		data << extract_season(season)
  	end
  end

  def extract_season(season)
  	season.tap do |data|
  		data[:season_ssid] = season["recordId"]
  		data[:name] = season["name"]
  		data[:season_name] = season["season"]
  		data[:group_count] = season["groupCount"]
  		data[:round_count] = season["roundCount"]
  		data[:sort_number] = season["sortNumber"]
  		data[:league_id] = league_by_ssid(season["leagueId"])
  		data[:current_group] = season["currentGroup"]
  		data[:group] = season["group"]
  	end
  end

  def leagues
  	@leagues ||= League.all.to_a
  end

  def league_by_ssid(ssid)
  	league = leagues.find{|b| b.league_ssid == ssid}
  	league.id
  end

  def get_seasons
    res = EsportBaseIntr.run(url_type: 'cupqualify')
    res.result["data"]
  end
end

