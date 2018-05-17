require 'rails_helper'

RSpec.describe DownloadUser, type: :model do
  it { should validate_presence_of(:email) }
end
