require 'rails_helper'

RSpec.describe ApiKeyInactiveWarningJob, type: :job do

  it 'emails inactive users' do
    user = create(:user, created_at: 2.years.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys).and_return([])
    ApiKeyInactiveWarningJob.perform_now
    expect(User.find(user.id).sent_warning_email).to eq(true)
  end

  it 'does not email active users' do
    user = create(:user, created_at: 2.years.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys).and_return([user.api_key])
    ApiKeyInactiveWarningJob.perform_now
    expect(User.find(user.id).sent_warning_email).to eq(false)
  end

  it 'does not email users prior to retention period' do
    user = create(:user, created_at: 6.months.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys).and_return([])
    ApiKeyInactiveWarningJob.perform_now
    expect(User.find(user.id).sent_warning_email).to eq(false)
  end

  it 'resets state of users who become active' do
    user = create(:user, created_at: 2.years.ago, user_type: 'api', api_key: SecureRandom.uuid, sent_warning_email: true)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys).and_return([user.api_key])
    ApiKeyInactiveWarningJob.perform_now
    expect(User.find(user.id).sent_warning_email).to eq(false)
  end

end
