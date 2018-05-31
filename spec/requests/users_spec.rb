require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:headers) { { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.secrets.http_auth_username, Rails.application.secrets.http_auth_password) } }

  describe 'POST /users' do
    let(:valid_attributes) { { email: 'admin@gov.uk' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes, headers: headers }

      it 'creates a user' do
        expect(json['email']).to eq('admin@gov.uk')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
