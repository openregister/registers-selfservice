require 'google/apis/sheets_v4'
require 'google/apis/analytics_v3'
require 'base64'

class AnalyticsUpdateService
  def initialize
    authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(Base64.decode64(ENV['GOOGLE_CREDENTIALS_JSON'])),
        scope: [Google::Apis::SheetsV4::AUTH_SPREADSHEETS, Google::Apis::AnalyticsV3::AUTH_ANALYTICS]
    )

    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorization
  end

  def add_new_service(api_key, department = 'Not available', service = 'Not available', options = { spreadsheet_id: ENV['SPREADSHEET_ID'], range: ENV['SPREADSHEET_RANGE'] })
    value_range = Google::Apis::SheetsV4::ValueRange.new(values: [[api_key, department, service]])
    @service.append_spreadsheet_value(options[:spreadsheet_id], options[:range], value_range, value_input_option: 'RAW')
  end
end