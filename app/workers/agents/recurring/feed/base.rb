# frozen_string_literal: true

class Agents::Recurring::Feed::Base < ApplicationAgent
  string :sync_intr_namespace

  validates :sync_intr_namespace, presence: true

  def namespace_as_const
    sync_intr_namespace.constantize
  end
end
