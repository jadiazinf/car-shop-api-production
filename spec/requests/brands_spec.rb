require 'rails_helper'

RSpec.describe 'Brands' do
  let!(:brand) { create(:brand, :valid_brand) }
  let!(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:user) { create(:user, :with_valid_attr) }
  let(:not_a_superadmin) do
    create(:user, :with_valid_attr, roles: %w[general admin supervisor technical])
  end
  let(:superadmin) do
    create(:user, :with_valid_attr, roles: %w[superadmin])
  end
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get(api_v1_brands_path,
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(api_v1_brands_path(brand),
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with not a valid user' do
      it 'returns an unauthorized' do
        put(api_v1_brand_path(brand),
            params: {
              brand: { name: 'Shangan' }
            }.to_json,
            headers: Devise::JWT::TestHelpers.auth_headers(headers, not_a_superadmin))
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:status]).to eq 'unauthorized'
      end
    end
    context 'with a valid user' do
      it 'returns sucess' do
        put(api_v1_brand_path(brand),
            params: {
              brand: { name: 'Shangan' }
            }.to_json,
            headers: Devise::JWT::TestHelpers.auth_headers(headers, superadmin))
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    let(:brand) { create(:brand, :valid_brand) }
    it 'returns a success response' do
      post(api_v1_brands_path,
           params: {
             brand:
           }.to_json,
           headers:)
      expect(response).to be_successful
    end
  end
end
