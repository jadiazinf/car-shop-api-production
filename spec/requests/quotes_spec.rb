require 'rails_helper'

RSpec.describe 'Quotes' do
  let(:quote) { build(:quote) }
  let(:admin) { create(:user_company, :valid_admin) }

  describe 'POST #create' do
    it 'returns a created response' do
      post(api_v1_quotes_path,
           params: { quotes: [quote.attributes.except('id')] },
           headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                          admin.user))
      expect(response).to have_http_status(:created)
    end
  end
end
