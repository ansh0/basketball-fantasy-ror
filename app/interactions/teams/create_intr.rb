# frozen_string_literal: true

# Responsible for creating offers
class Teams::CreateIntr < ApplicationInteraction
  def execute
    @teams = get_teams
    Team.import columns, get_teams_data(@teams), validate: true
  end

  def columns
    [
      :team_ssid,
      :name,
      :short_name,
      :logo,
      :website,
      :conference,
      :division,
      :city,
      :venue,
      :capacity,
      :join_year,
      :champion_count,
      :coach,
      :league_id,
    ]
  end

  def get_teams_data(teams)
    teams.each_with_object([]) do |team, data|
      begin
        data << extract_team(team)
      rescue
        next
      end
    end
  end

  def extract_team(team)
    team.tap do |data|
      data[:team_ssid] = team["teamId"]
      data[:name] = team["name"]
      data[:short_name] = team["shortName"]
      data[:logo] = team["logo"]
      data[:website] = team["website"]
      data[:conference] = team["conference"]
      data[:division] = team["division"]
      data[:city] = team["city"]
      data[:venue] = team["venue"]
      data[:capacity] = team["capacity"]
      data[:join_year] = team["joinYear"]
      data[:champion_count] = team["championCount"]
      data[:coach] = team["coach"]
      data[:league_id] = league_by_ssid(team["leagueId"])    
    end
  end

  def leagues
    @leagues ||= League.all.to_a
  end

  def league_by_ssid(ssid)
    league = leagues.find{|b| b.league_ssid == ssid}
    league.id
  end

  def get_teams
    res = EsportBaseIntr.run(url_type: 'team')
    res.result["data"]
  end
end