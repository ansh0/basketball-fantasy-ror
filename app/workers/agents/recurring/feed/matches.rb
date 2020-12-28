class Agents::Recurring::Feed::Matches < Agents::Recurring::Feed::Base
  string :league_ssid

  validates :league_ssid, presence: true
# frozen_string_literal: true
  def execute
    namespace_as_const.run!(league_ssid: league_ssid)
  end
end
