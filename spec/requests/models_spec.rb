require 'rails_helper'

RSpec.describe 'Models' do
  let(:new_model) { create(:model) }
  let(:model) { build(:model, brand: new_model.brand) }
  let(:not_a_superadmin) { create(:user_company, :valid_admin) }
  let(:superadmin) { create(:user_company, :valid_superadmin) }

  describe 'GET #index' do
    let(:user) { create(:user, :with_valid_attr) }

    it 'returns a success response' do
      get(api_v1_super_admin_models_path,
          headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' }, user))
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user, :with_valid_attr) }

    it 'returns a api_v1_super_admin_models_path response' do
      get(api_v1_super_admin_models_path(new_model),
          headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' }, user))
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with not a valid user' do
      let(:params) do
        {
          model: { name: 'Wagoneer', brand_id: new_model.brand_id },
          company_id: not_a_superadmin.company_id
        }
      end

      it 'returns forbidden' do
        put(api_v1_super_admin_model_path(new_model),
            params:,
            headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                           not_a_superadmin.user))
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with a valid user' do
      let(:params) do
        {
          model: { name: 'Wagoneer', brand_id: new_model.brand_id },
          company_id: superadmin.company_id
        }
      end

      it 'returns success' do
        put(api_v1_super_admin_model_path(new_model),
            params:,
            headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                           superadmin.user))
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'with not a valid user' do
      let(:params) do
        {
          model:,
          company_id: not_a_superadmin.company_id
        }
      end

      it 'returns forbidden' do
        post(api_v1_super_admin_models_path,
             params:,
             headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                            not_a_superadmin.user))
        expect(response.parsed_body[:status]).to eq 'forbidden'
      end
    end

    context 'with a valid user' do
      let(:params) do
        {
          model: model.attributes,
          company_id: superadmin.company_id
        }
      end

      it 'returns success' do
        post(api_v1_super_admin_models_path,
             params:,
             headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                            superadmin.user))
        expect(response).to be_successful
      end
    end
  end
end
