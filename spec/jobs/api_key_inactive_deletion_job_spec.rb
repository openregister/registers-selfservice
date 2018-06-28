require 'rails_helper'

RSpec.describe ApiKeyInactiveDeletionJob, type: :job do
  it 'retains active users' do
    user_active = create(:user, created_at: 2.years.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys_from_ga).with(365).and_return([user_active.api_key])
    ApiKeyInactiveDeletionJob.perform_now
    expect(User.count).to eq(1)
  end

  it 'deletes inactive users' do
    create(:user, created_at: 2.years.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys_from_ga).with(365).and_return([])
    ApiKeyInactiveDeletionJob.perform_now
    expect(User.count).to eq(0)
  end

  it 'retains users created within retention period' do
    create(:user, created_at: 6.months.ago, user_type: 'api', api_key: SecureRandom.uuid)
    allow(GoogleAnalyticsQueries).to receive(:get_active_api_keys_from_ga).with(365).and_return([])
    ApiKeyInactiveDeletionJob.perform_now
    expect(User.count).to eq(1)
  end
end
