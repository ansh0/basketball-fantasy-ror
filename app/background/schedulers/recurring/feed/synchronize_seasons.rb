# frozen_string_literal: true

class Schedulers::Recurring::Feed::SynchronizeSeasons < Schedulers::Base
  def execute
    add_or_adjust_recurring_job_if_required(job_uniq_name, schedule_config)
  end

  private

  # Every noon and midnight
  CRON = '10 0,12 * * *'

  def schedule_config
    {
      'cron' => cron_timing,
      'class' => Agents::Recurring::Feed::Seasons.name,
      'args' => { sync_intr_namespace: sync_season_intr_namespace.name },
      'description' => "Synchronize Sesons \n#{humanize_cron(CRON)}",
      'include_metadata' => true,
      'enabled' => true,
      'queue' => 'default'
    }.freeze
  end

  def sync_season_intr_namespace
    "Seasons::CreateIntr".constantize
  end

  def cron_timing
    CRON
  end

  SEASON_SCHEDULE_RECURRING_JOB_NAME_PREFIX = 'SEASONS_SYNC'
  def job_uniq_name
    "#{SEASON_SCHEDULE_RECURRING_JOB_NAME_PREFIX}"
  end
end
