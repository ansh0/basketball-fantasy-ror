# frozen_string_literal: true

class Schedulers::Recurring::Feed::SynchronizeSeasonMatches < Schedulers::Base
  def execute
    League.all.each do |league|
      add_or_adjust_recurring_job_if_required(job_uniq_name(league), schedule_config(league))
    end
  end

  private

  # Every noon and midnight
  CRON = '10 0,12 * * *'

  def schedule_config(league)
    {
      'cron' => cron_timing,
      'class' => Agents::Recurring::Feed::Matches.name,
      'args' => { sync_intr_namespace: sync_intr_namespace.name, league_ssid: league.league_ssid },
      'description' => "Synchronize Matches \n#{humanize_cron(CRON)}",
      'include_metadata' => true,
      'enabled' => true,
      'queue' => 'default'
    }.freeze
  end

  def sync_intr_namespace
    "Matches::CreateIntr".constantize
  end

  def cron_timing
    CRON
  end

  FEED_MATCHES_RECURRING_JOB_NAME_PREFIX = 'MATCHES_SYNC'
  def job_uniq_name(league)
    "#{FEED_MATCHES_RECURRING_JOB_NAME_PREFIX}||League##{league.id}"
  end
end
