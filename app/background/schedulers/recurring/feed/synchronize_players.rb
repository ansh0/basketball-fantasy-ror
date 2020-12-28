# frozen_string_literal: true

class Schedulers::Recurring::Feed::SynchronizePlayers < Schedulers::Base
  def execute
    Team.all.each do |team|
      add_or_adjust_recurring_job_if_required(job_uniq_name(team), schedule_config(team))
    end
  end

  private

  # Every noon and midnight
  CRON = '10 0,12 * * *'

  def schedule_config(team)
    {
      'cron' => cron_timing,
      'class' => Agents::Recurring::Feed::Players.name,
      'args' => { sync_intr_namespace: sync_intr_namespace.name, team_ssid: team.team_ssid },
      'description' => "Synchronize Players \n#{humanize_cron(CRON)}",
      'include_metadata' => true,
      'enabled' => true,
      'queue' => 'default'
    }.freeze
  end

  def sync_intr_namespace
    "Players::CreateIntr".constantize
  end

  def cron_timing
    CRON
  end

  FEED_MATCHES_RECURRING_JOB_NAME_PREFIX = 'PLAYERS_SYNC'
  def job_uniq_name(team)
    "#{FEED_MATCHES_RECURRING_JOB_NAME_PREFIX}||Team##{team.id}"
  end
end
