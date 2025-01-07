require 'rails_helper'
RSpec.describe 'Users' do
  let(:user) { create(:user, :with_valid_attr) }
  let!(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'PATCH #update' do
    let(:params) do
      {
        user: { first_name: 'Miguel' }
      }.to_json
    end

    it 'returns a success response' do
      patch api_v1_user_path(user.id),
            params:,
            headers: auth_headers
      expect(response).to be_successful
    end
  end

  describe 'GET #get_new_token' do
    it 'returns http status ok response' do
      get(new_token_api_v1_user_path(user.id), headers:)
      expect(response).to have_http_status(:ok)
    end

    it 'returns http status bad request response' do
      get(new_token_api_v1_user_path(-1), headers:)
      expect(response).to have_http_status(:bad_request)
    end
  end
end
