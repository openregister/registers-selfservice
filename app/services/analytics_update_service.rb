require 'google/apis/sheets_v4'
require 'google/apis/analytics_v3'
require 'base64'

class AnalyticsUpdateService
  def initialize
    authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(Base64.decode64(Rails.application.secrets.google_api_key)),
      scope: [Google::Apis::SheetsV4::AUTH_SPREADSHEETS, Google::Apis::AnalyticsV3::AUTH_ANALYTICS]
    )

    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorization
  end

  def add_new_service(api_key, department, non_gov_use_category, is_government, options = { spreadsheet_id: Rails.application.secrets.spreadsheet_id, range: Rails.application.secrets.spreadsheet_range })
    department ||= is_government == false ? 'Non government' : '(not set)'
    value_range = Google::Apis::SheetsV4::ValueRange.new(values: [[api_key, department, non_gov_use_category ? "Non-Government - #{non_gov_use_category.gsub'_',' '}" : 'Government']])
    @service.append_spreadsheet_value(options[:spreadsheet_id], options[:range], value_range, value_input_option: 'RAW')
  end
end
