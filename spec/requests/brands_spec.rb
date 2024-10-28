require 'rails_helper'

RSpec.describe 'Brands' do
  let(:brand) { create(:brand) }
  let(:user) { create(:user, :with_valid_attr) }
  let(:not_a_superadmin) { create(:user_company, :valid_admin) }
  let(:superadmin) { create(:user_company, :valid_superadmin) }

  describe 'GET #index' do
    it 'returns a success response' do
      get(api_v1_super_admin_brands_path,
          headers: { 'Accept' => 'application/json' })
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(api_v1_super_admin_brands_path(brand),
          headers: { 'Accept' => 'application/json' })
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with not a valid user' do
      let(:params) do
        {
          brand: { name: 'Shangan' },
          company_id: not_a_superadmin.company_id
        }
      end

      it 'returns an unauthorized' do
        put(api_v1_super_admin_brand_path(brand),
            params:,
            headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                           not_a_superadmin.user))
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a valid user' do
      let(:params) do
        {
          brand: { name: 'Shangan' },
          company_id: superadmin.company_id
        }
      end

      it 'returns sucess' do
        put(api_v1_super_admin_brand_path(brand),
            params:,
            headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                           superadmin.user))
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    let(:brand) { build(:brand) }
    let(:params) do
      {
        brand: brand.attributes,
        company_id: superadmin.company_id
      }
    end

    it 'returns a success response' do
      post(api_v1_super_admin_brands_path,
           params:,
           headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                          superadmin.user))
      expect(response).to have_http_status(:ok)
    end
  end
end
