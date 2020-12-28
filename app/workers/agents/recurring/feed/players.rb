class Agents::Recurring::Feed::Players < Agents::Recurring::Feed::Base
  string :team_ssid

  validates :team_ssid, presence: true
# frozen_string_literal: true
  def execute
    namespace_as_const.run!(team_ssid: team_ssid)
  end
end
