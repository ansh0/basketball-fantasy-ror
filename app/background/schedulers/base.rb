# frozen_string_literal: true

class Schedulers::Base < ApplicationScheduler
  include Sidekiq::SchedulerHelper

  # def teams_of_running_and_upcoming_seasons
  #   @teams_of_running_and_upcoming_seasons ||= Feed::Team.joins(feed_season: :league)
  #                                                        .where('feed_seasons.end_date >= ?', Time.zone.today)
  #                                                        .eager_load(feed_season: :league)
  # end

  # Time.zone.now - 6.hours because if cron scheduler restarts in middle of match the cron will be removed
  # so including those matches explicitly.
  def live_and_upcoming_season_matches_within_day
    Feed::SeasonMatch.where('scheduled_for >= ?', Time.zone.now - 6.hours)
                     .where('scheduled_for <= ?', Time.zone.now + 1.day)
                     .eager_load(feed_season: :league)
  end
end
