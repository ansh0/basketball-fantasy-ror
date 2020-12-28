# frozen_string_literal: true

module Sidekiq::SchedulerHelper
  extend ActiveSupport::Concern

  def add_or_adjust_recurring_job_if_required(cron_name, job_config)
    # This automatically creates or updates a schedule as per the provided name and configuration.
    Sidekiq.set_schedule cron_name, convert_past_into_near(job_config)
  end

  def add_single_shot(uniq_job_name, job_config)
    delete_existing_scheduled_job_by_jid(uniq_job_name)
    config = job_config.with_indifferent_access
    klass = config['class'].to_s.constantize
    perform_at = config['at']&.to_i || config['in'].to_i.seconds
    args = config['args']
    klass.set(jid: uniq_job_name.to_s).perform_at(perform_at, args)
  end

  def delete_existing_scheduled_job_by_jid(uniq_job_name)
    r = Sidekiq::ScheduledSet.new
    r.select do |scheduled|
      scheduled.jid == uniq_job_name
    end.map(&:delete)
  end

  def convert_past_into_near(job_config)
    job_config.with_indifferent_access.tap do |config|
      if cron_config_in_past?(config)
        config[:cron].last[:first_at].delete(:first_at)
        config[:cron].last[:first_in] = '3s'
      end
      if config[:at]&.past?
        config.delete(:at)
        config[:in] = '3s'
      end
    end
  end

  def cron_config_in_past?(config)
    config[:cron].class == Array && config[:cron].last.respond_to?(:[]) && config[:cron].last[:first_at]&.past?
  end

  def remove_recurring_job_if_exists(cron_name)
    Sidekiq.remove_schedule cron_name
  end

  def fetch_cron(name)
    Sidekiq.get_schedule(name)
  end

  def all_crons
    Sidekiq.get_all_schedules
  end

  def humanize_cron(expression)
    Cronex::ExpressionDescriptor.new(expression).description
  end

  def cron_timing
    raise 'Not Defined'
  end
end
