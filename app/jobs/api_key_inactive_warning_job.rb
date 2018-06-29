require_relative 'google_analytics_queries'

class ApiKeyInactiveWarningJob < ApplicationJob
  queue_as :default

  def perform
    activity_period = 11.months.ago
    active_api_keys = GoogleAnalyticsQueries.get_active_api_keys_from_ga(activity_days)
    api_keys_older_than_activity_period = User.where(user_type: 'api')
                                                .where.not(email: nil)
                                                .where("created_at <= :date", date: activity_period)
                                                .pluck(:api_key)
    inactive_api_keys = api_keys_older_than_activity_period - active_api_keys
    inactive_api_users = User.where(api_key: inactive_api_keys)
    inactive_api_users.map { |u| NotifyMailer.api_key_inactive_warning(u).deliver_later }
  end
end
