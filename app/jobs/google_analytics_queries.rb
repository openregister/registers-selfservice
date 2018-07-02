require 'google/apis/analyticsreporting_v4'

module GoogleAnalyticsQueries
  include Google::Apis::AnalyticsreportingV4
  include Google::Auth

module_function

  def get_active_api_keys(start_date)
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
      date_ranges: [DateRange.new(start_date: start_date.strftime('%Y-%m-%d'), end_date: 'today')]
      )
    response = service.batch_get_reports(GetReportsRequest.new(report_requests: [rr]))
    response.reports.first.data.rows.map { |r| r.dimensions.first }
  end
end
