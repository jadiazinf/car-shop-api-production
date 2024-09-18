require 'rails_helper'

RSpec.describe 'Models' do
  let!(:brand) { create(:brand, :valid_brand) }
  let!(:new_model) { create(:model, :valid_model, brand:) }
  let!(:model) { build(:model, :valid_model, brand:) }
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
      get(api_v1_models_path,
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(api_v1_model_path(new_model),
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with not a valid user' do
      it 'returns an unauthorized' do
        put(api_v1_model_path(new_model),
            params: {
              model: { name: 'Wagoneer', brand_id: brand[:id] }
            }.to_json,
            headers: Devise::JWT::TestHelpers.auth_headers(headers, not_a_superadmin))
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:status]).to eq 'unauthorized'
      end
    end
    context 'with a valid user' do
      it 'returns success' do
        put(api_v1_model_path(new_model),
            params: {
              model: { name: 'Wagoneer', brand_id: brand[:id] }
            }.to_json,
            headers: Devise::JWT::TestHelpers.auth_headers(headers, superadmin))
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create.rb' do
    context 'with not a valid user' do
      it 'returns an unauthorized' do
        post(api_v1_models_path,
             params: {
               model:
             }.to_json,
             headers: Devise::JWT::TestHelpers.auth_headers(headers, not_a_superadmin))
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:status]).to eq 'unauthorized'
      end
    end
    context 'with a valid user' do
      it 'returns success' do
        post(api_v1_models_path,
             params: {
               model:
             }.to_json,
             headers: Devise::JWT::TestHelpers.auth_headers(headers, superadmin))
        expect(response).to be_successful
      end
    end
  end
end
