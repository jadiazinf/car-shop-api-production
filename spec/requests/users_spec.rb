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
end
