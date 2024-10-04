require 'rails_helper'

RSpec.describe 'Models' do
  let!(:new_model) { create(:model, :valid_model) }
  let!(:model) { build(:model, :valid_model) }
  let!(:headers) { { 'Accept' => 'application/json' } }
  let(:user) { create(:user, :with_valid_attr) }
  let(:not_a_superadmin) { create(:user_company, :valid_admin) }
  let(:superadmin) { create(:user_company, :valid_superadmin) }
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get(api_v1_super_admin_models_path,
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a api_v1_super_admin_models_path response' do
      get(api_v1_super_admin_models_path(new_model),
          headers:)
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with not a valid user' do
      it 'returns an unauthorized' do
        put(api_v1_super_admin_model_path(new_model),
            params: {
              model: { name: 'Wagoneer', brand_id: new_model.brand_id },
              company_id: not_a_superadmin.company_id
            },
            headers: Devise::JWT::TestHelpers.auth_headers(headers, not_a_superadmin.user))
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context 'with a valid user' do
      it 'returns success' do
        put(api_v1_super_admin_model_path(new_model),
            params: {
              model: { name: 'Wagoneer', brand_id: new_model.brand_id },
              company_id: superadmin.company_id
            },
            headers: Devise::JWT::TestHelpers.auth_headers(headers, superadmin.user))
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'with not a valid user' do
      it 'returns an unauthorized' do
        post(api_v1_super_admin_models_path,
             params: {
               model:,
               company_id: not_a_superadmin.company_id
             },
             headers: Devise::JWT::TestHelpers.auth_headers(headers, not_a_superadmin.user))
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:status]).to eq 'unauthorized'
      end
    end
    context 'with a valid user' do
      it 'returns success' do
        post(api_v1_super_admin_models_path,
             params: {
               model: model.attributes,
               company_id: superadmin.company_id
             },
             headers: Devise::JWT::TestHelpers.auth_headers(headers, superadmin.user))
        expect(response).to be_successful
      end
    end
  end
end
