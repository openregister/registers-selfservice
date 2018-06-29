require_relative 'google_analytics_queries'

class ApiKeyInactiveDeletionJob < ApplicationJob
  queue_as :default

  def perform
    active_api_keys = GoogleAnalyticsQueries.get_active_api_keys(1.year.ago)
    api_keys_older_than_retention_period = User.where(user_type: 'api')
                                                .where.not(email: nil)
                                                .where("created_at <= :date", date: 1.year.ago)
                                                .pluck(:api_key)
    inactive_api_keys = api_keys_older_than_retention_period - active_api_keys
    inactive_api_users = User.where(api_key: inactive_api_keys)
    inactive_api_users.map { |u| NotifyMailer.api_key_inactive_deletion(u).deliver_later }
    inactive_api_users.destroy_all
  end
end
