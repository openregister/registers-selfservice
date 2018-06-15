require 'google/apis/analyticsreporting_v4'

class ApiKeyRetentionJob < ApplicationJob
  queue_as :default

  module GoogleAnalyticsQueries
    include Google::Apis::AnalyticsreportingV4
    include Google::Auth

    def self.get_active_api_keys_from_ga
      authorization = ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(Base64.decode64(Rails.application.secrets.google_api_key)),
        scope: [Google::Apis::AnalyticsreportingV4::AUTH_ANALYTICS_READONLY]
        )

      service = AnalyticsReportingService.new
      service.authorization = authorization
      rr = ReportRequest.new(
        view_id: Rails.application.secrets.google_analytics_view_id,
        dimensions: [Dimension.new(name: 'ga:dimension2')],
        metrics: [Metric.new(expression: 'ga:pageviews')],
        date_ranges: [DateRange.new(start_date: '365DaysAgo', end_date: 'today')]
        )
      response = service.batch_get_reports(GetReportsRequest.new(report_requests: [rr]))
      response.reports.first.data.rows.map { |r| r.dimensions.first }
    end
  end

  def perform
    active_api_keys = GoogleAnalyticsQueries.get_active_api_keys_from_ga
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
