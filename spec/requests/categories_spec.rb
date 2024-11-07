require 'rails_helper'

RSpec.describe 'Categories' do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:users) do
    { superadmin: create(:user_company, :valid_superadmin),
      admin: create(:user_company, :valid_admin) }
  end
  let(:auth_headers) do
    { superadmin: Devise::JWT::TestHelpers.auth_headers(headers, users[:superadmin].user),
      admin: Devise::JWT::TestHelpers.auth_headers(headers, users[:admin].user) }
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get(api_v1_categories_path, headers:, params: { page: 10 })
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:category) { create(:category) }

    it 'returns a single category' do
      get(api_v1_category_path(category.id), headers:)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:category) }
    let(:invalid_attributes) { attributes_for(:category, :invalid) }

    context 'with authentication scenarios' do
      it 'shows unauthorized when not a superadmin' do
        post(api_v1_categories_path(company_id: users[:admin].company_id),
             headers: auth_headers[:admin],
             params: { category: valid_attributes }, as: :json)
        expect(response).to have_http_status(:unauthorized)
      end

      it 'creates a category when a superadmin and valid attributes' do
        post(api_v1_categories_path(company_id: users[:superadmin].company_id),
             headers: auth_headers[:superadmin],
             params: { category: valid_attributes }, as: :json)
        expect(response).to have_http_status(:created)
      end

      it 'gives an unprocessable entity when attributes are invalid' do
        post(api_v1_categories_path(company_id: users[:superadmin].company_id),
             headers: auth_headers[:superadmin],
             params: { category: invalid_attributes }, as: :json)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }

    it 'shows unauthorized when not a superadmin for update' do
      patch(api_v1_category_path(id: category.id, company_id: users[:admin].company_id),
            headers: auth_headers[:admin],
            params: { category: { name: 'Updated name' } }, as: :json)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'updates a category with valid attributes' do
      patch(api_v1_category_path(id: category.id, company_id: users[:superadmin].company_id),
            headers: auth_headers[:superadmin],
            params: { category: { name: 'Updated Name' } }, as: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'gives an unprocessable entity when attributes are invalid for update' do
      patch(api_v1_category_path(id: category.id, company_id: users[:superadmin].company_id),
            headers: auth_headers[:superadmin],
            params: { category: { name: nil } }, as: :json)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
