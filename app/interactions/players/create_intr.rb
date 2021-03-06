# frozen_string_literal: true

# Responsible for creating offers
class Players::CreateIntr < ApplicationInteraction
  string :team_ssid

  validates :team_ssid, presence: true
  def execute
    @players = get_players
    Player.import get_players_data(@players), on_duplicate_key_update: { conflict_target: selector, columns: setter }
  end

  def setter
    [
      :name,
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

  def selector
    [:player_ssid, :team_id]
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
    res = EsportBaseIntr.run(url_type: 'player', teamId: team_ssid)
    res.result["data"]
  end
end