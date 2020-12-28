# frozen_string_literal: true

class Schedulers::Recurring::Feed::SynchronizeStats < Schedulers::Base
  LEAGUE_SCHEDULE_RECURRING_JOB_NAME_PREFIX = 'STATS_SYNC'

  def execute
    add_or_adjust_recurring_job_if_required(job_uniq_name, schedule_config)
  end

  private

  # Every 5 minutes
  CRON = '*/30 * * * *'

  def schedule_config
    {
      'cron' => cron_timing,
      'class' => Agents::Recurring::Feed::Stats.name,
      'args' => { sync_intr_namespace: sync_stat_intr_namespace.name },
      'description' => "Synchronize Stats \n#{humanize_cron(CRON)}",
      'include_metadata' => true,
      'enabled' => true,
      'queue' => 'default'
    }.freeze
  end

  def sync_stat_intr_namespace
    "Stats::MatchPlayerScoreIntr".constantize
  end

  def cron_timing
    CRON
  end

  def job_uniq_name
    LEAGUE_SCHEDULE_RECURRING_JOB_NAME_PREFIX
  end
end
