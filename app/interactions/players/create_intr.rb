# frozen_string_literal: true

# Responsible for creating offers
class Players::CreateIntr < ApplicationInteraction
  def execute
    @players = get_players
    Player.import columns, get_players_data(@players), validate: true
  end

  def columns
    [
      :player_ssid,
      :name,
      :team_id,
      :place,
      :birthday,
      :height_cm,
      :weight_kg,
      :photo,
      :nbaAge,
      :salary,
      :number
    ]
  end

  def get_players_data(players)
    players.each_with_object([]) do |player, data|
      begin
        data << extract_player(player)
      rescue
        next
      end
    end
  end

  def extract_player(player)
    player.tap do |data|
      data[:player_ssid] = player["playerId"]
      data[:name] = player["name"]
      data[:team_id] = team_by_ssid(player["teamId"])
      data[:place] = player["place"]
      data[:birthday] = player["birthday"]
      data[:height_cm] = player["height"]
      data[:weight_kg] = player["weight"]
      data[:photo] = player["photo"]
      data[:nbaAge] = player["nbaAge"]
      data[:salary] = player["salary"]
      data[:number] = player["number"]
    end
  end

  def teams
    @teams ||= Team.all.to_a
  end

  def team_by_ssid(ssid)
    team = teams.find{|b| b.team_ssid == ssid}
    team.id
  end

  def get_players
    res = EsportBaseIntr.run(url_type: 'player')
    res.result["data"]
  end
end