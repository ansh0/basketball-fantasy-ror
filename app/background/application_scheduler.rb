# frozen_string_literal: true

class ApplicationScheduler < ApplicationInteraction
  include Sidekiq::SchedulerHelper
end
