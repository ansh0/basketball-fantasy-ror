# frozen_string_literal: true

class Agents::Cron::CronSync < ApplicationAgent
  def execute # rubocop:disable Metrics/MethodLength, AbcSize

    # Basketball API Feed
    Schedulers::Recurring::Feed::SynchronizeLeagues.run!
    Schedulers::Recurring::Feed::SynchronizeSeasons.run!
    Schedulers::Recurring::Feed::SynchronizeTeams.run!
    Schedulers::Recurring::Feed::SynchronizePlayers.run!
    Schedulers::Recurring::Feed::SynchronizeSeasonMatches.run!

    # Stats and scoring
    Schedulers::Recurring::Feed::SynchronizeStats.run!


    # Schedulers::Recurring::Season::UpdateEndDateIntr.run!
    # Schedulers::Recurring::Feed::SynchronizeSeasonWeeks.run!
    # Schedulers::Recurring::Feed::SynchronizeMatchStats.run!
    # Schedulers::Recurring::Feed::SynchronizePlayerMatchStats.run!
    # Schedulers::Recurring::Feed::SynchronizeCricketPlayerStats.run!

    # Schedulers::Recurring::Score::Base::UpdatePlayerMatchScores.run!
    # Schedulers::Recurring::Score::Base::UpdateLineupPlayerScores.run!
    # Schedulers::Recurring::Score::Base::UpdateLineupTotalScores.run!


    # Schedulers::SingleShot::Contest::CancelContests.run!
    # Schedulers::SingleShot::Contest::LiveContests.run!
    # Schedulers::SingleShot::Contest::Winner.run!

    # Schedulers::SingleShot::Contest::ClassifyUsers.run!
    # Schedulers::Recurring::GoldMembers::UpdatePoints.run!
    # Schedulers::Recurring::GoldMembers::UserParticipation.run!
    # Schedulers::Recurring::User::TopOnLeaderboard.run!
    # Schedulers::Recurring::User::AssignBadgeForTopOnLeaderboard.run!

    # Schedulers::SingleShot::Lineup::UserLineupCheck.run!
    # Schedulers::Recurring::User::WinningRatio.run!

    nil
  end
end
