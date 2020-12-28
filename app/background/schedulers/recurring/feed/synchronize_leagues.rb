# frozen_string_literal: true

class Schedulers::Recurring::Feed::SynchronizeLeagues < Schedulers::Base
  LEAGUE_SCHEDULE_RECURRING_JOB_NAME_PREFIX = 'LEAGUES_SYNC'

  def execute
    add_or_adjust_recurring_job_if_required(job_uniq_name, schedule_config)
  end

  private

  # Every noon and midnight
  CRON = '10 0,12 * * *'

  def schedule_config
    {
      'cron' => cron_timing,
      'class' => Agents::Recurring::Feed::Leagues.name,
      'args' => { sync_intr_namespace: sync_league_intr_namespace.name },
      'description' => "Synchronize League \n#{humanize_cron(CRON)}",
      'include_metadata' => true,
      'enabled' => true,
      'queue' => 'default'
    }.freeze
  end

  def sync_league_intr_namespace
    "Leagues::CreateIntr".constantize
  end

  def cron_timing
    CRON
  end

  def job_uniq_name
    LEAGUE_SCHEDULE_RECURRING_JOB_NAME_PREFIX
  end
end
