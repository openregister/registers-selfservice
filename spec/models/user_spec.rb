require 'rails_helper'

RSpec.describe User, type: :model do
  context 'is a government user' do
    before { allow(subject).to receive(:is_government).and_return(true) }
    it { should validate_presence_of(:email) }
  end

  context 'is not a government user' do
    before { allow(subject).to receive(:is_government).and_return(false) }
    it { should_not validate_presence_of(:email) }
  end
end
