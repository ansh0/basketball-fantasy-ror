# frozen_string_literal: true

# Responsible for creating offers
class Leagues::CreateIntr < ApplicationInteraction
  def execute
    League.import get_leagues_data(get_leagues), on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
    [:color, :short_name, :league_name, :league_type, :match_season, :country_id, :country, :league_kind, :logo, :part_time]
  end

  def selector
    [:league_ssid]
  end

  def get_leagues_data(leagues)
    leagues.each_with_object([]) do |league, data|
      data << extract_league(league)
    end
  end

  def extract_league(league)
    league.tap do |lea|
      lea[:league_ssid] = league["leagueId"]
      lea[:color] = league["color"]
      lea[:league_name] = league["leagueName"]
      lea[:short_name] = league["leagueShortName"]
      lea[:league_type] = league["leagueType"]
      lea[:match_season] = league["currentMatchSeason"]
      lea[:country_id] = league["countryId"]
      lea[:country] = league["country"]
      lea[:league_kind] = league["leagueKind"]
      lea[:logo] = league["logo"]
      lea[:part_time] = league["partTime"]
    end
  end

  def get_leagues
    leagues = EsportBaseIntr.run(url_type: 'league')
    leagues.result["data"]
  end
end