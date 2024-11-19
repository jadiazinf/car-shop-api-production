require 'rails_helper'

RSpec.describe 'Services' do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:users) do
    {
      superadmin: create(:user_company, :valid_superadmin),
      admin: create(:user_company, :valid_admin)
    }
  end
  let(:auth_headers) do
    {
      superadmin: Devise::JWT::TestHelpers.auth_headers(headers, users[:superadmin].user),
      admin: Devise::JWT::TestHelpers.auth_headers(headers, users[:admin].user)
    }
  end

  describe 'GET #index' do
    it 'returns a list with services paginated' do
      get(api_v1_services_path, headers:, params: { page: 1 })
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:service) { create(:service) }

    it 'returns a single service' do
      get(api_v1_service_path(service.id), headers:)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      attributes_for(:service).merge(company_id: users[:admin].company_id,
                                     category_id: create(:category).id)
    end
    let(:invalid_attributes) { attributes_for(:service, :invalid_service) }

    context 'with authentication scenarios' do
      it 'shows forbidden when not an admin' do
        post(api_v1_services_path(company_id: users[:superadmin].company_id),
             headers: auth_headers[:superadmin], params: { service: valid_attributes }, as: :json)
        expect(response).to have_http_status(:forbidden)
      end

      it 'creates a service when an admin and valid attributes' do
        post(api_v1_services_path(company_id: users[:admin].company_id),
             headers: auth_headers[:admin],
             params: { service: valid_attributes }, as: :json)
        expect(response).to have_http_status(:created)
      end

      it 'gives an unprocessable entity when attributes are invalid' do
        post(api_v1_services_path(company_id: users[:admin].company_id),
             headers: auth_headers[:admin],
             params: { service: invalid_attributes }, as: :json)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH #update' do
    let(:service) { create(:service) }

    it 'shows forbidden when not an admin for update' do
      patch(api_v1_service_path(id: service.id, company_id: users[:superadmin].company_id),
            headers: auth_headers[:superadmin],
            params: { service: { name: 'Updated name' } }, as: :json)
      expect(response).to have_http_status(:forbidden)
    end

    it 'updates a service with valid attributes' do
      patch(api_v1_service_path(id: service.id, company_id: users[:admin].company_id),
            headers: auth_headers[:admin], params: { service: { name: 'Updated Name' } }, as: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'gives an unprocessable entity when attributes are invalid for update' do
      patch(api_v1_service_path(id: service.id, company_id: users[:admin].company_id),
            headers: auth_headers[:admin], params: { service: { name: nil } }, as: :json)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
