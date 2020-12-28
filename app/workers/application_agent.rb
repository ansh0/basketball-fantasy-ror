# frozen_string_literal: true

class ApplicationAgent < ApplicationInteraction
  include Sidekiq::Worker

  def perform(hash_as_args = {}, metadata = {})
    logger.info "#{self.class.name} Worker Started #{self.class} #{hash_as_args} #{metadata}"
    self.class.run!(hash_as_args.merge(custom_logger: logger))

    logger.info "#{self.class.name} Worker Finished Successfully #{self.class} #{hash_as_args} #{metadata}"
  rescue Exception => exception # rubocop:disable Lint/RescueException
    # rescuing "Exception" is really not a good idea, I agree! for this case we are gonna re-raise it just after a log.
    log_exception exception, hash_as_args, metadata
    # notify_raven exception, hash_as_args
    raise exception
  end

  def log_exception(exception, context, metadata)
    logger.error "#{self.class.name} Worker Failure #{self.class} #{exception} #{context} #{metadata}"
  end

  def logger
    Sidekiq.logger
  end

  sidekiq_retries_exhausted do |message, exception|
    logger.error "#{self.class.name} Worker Retries Exhausted #{self.class} #{exception} #{message}"
  end
end
