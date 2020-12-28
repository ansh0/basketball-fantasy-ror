# frozen_string_literal: true

class Agents::Recurring::Feed::Seasons < Agents::Recurring::Feed::Base
  def execute
    namespace_as_const.run!
  end
end
