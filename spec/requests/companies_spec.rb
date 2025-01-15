require 'rails_helper'

RSpec.describe 'Companies' do
  let(:company) { build(:company) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'POST #create' do
    let(:user) { create(:user, :registration) }
    let(:params) do
      {
        name: company.name,
        dni: company.dni,
        email: company.email,
        address: company.address,
        location_id: company.location.id,
        user_ids: [user.id],
        user: user.attributes
      }
    end

    it 'creates a new company' do
      post(api_v1_companies_path,
           headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                          user), params:)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    let(:admin) { create(:user_company, :valid_admin) }
    let(:params) do
      {
        name: 'New Name',
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpeg')]
      }
    end

    it 'updates a company' do
      headers = Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                      admin.user)
      patch(api_v1_company_path(id: admin.company_id, company_id: admin.company_id),
            headers:, params:)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #set_profile_image' do
    let(:admin) { create(:user_company, :valid_admin) }
    let(:technician) { create(:user_company, :valid_technical) }
    let(:headers) do
      Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                            admin.user)
    end

    context 'when not an admin or superadmin user case' do
      let(:headers) do
        Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                              technician.user)
      end

      let(:params) do
        { profile_image: fixture_file_upload('image.jpg', 'image/jpeg') }
      end

      it 'respond with forbidden because wrong user role' do
        patch(set_profile_image_api_v1_company_path(id: technician.user_id,
                                                    company_id: technician.company_id), headers:,
                                                                                        params: {})
        expect(response).to have_http_status(:forbidden)
      end
    end

    it 'respond unprocessable content because wrong image format' do
      patch(set_profile_image_api_v1_company_path(id: admin.company_id,
                                                  company_id: admin.company_id), headers:,
                                                                                 params: {})
      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'sets the company profile' do
      patch(set_profile_image_api_v1_company_path(id: admin.company_id,
                                                  company_id: admin.company_id),
            headers:, params: { profile_image: fixture_file_upload('image.jpg', 'image/jpeg') })
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #search_companies_with_filters' do
    let(:service) { create(:service) }

    it 'responds with a list of companies' do # rubocop:disable RSpec/ExampleLength
      get(search_companies_with_filters_api_v1_companies_path(page: 1,
                                                              location_id: service.company.location_id, # rubocop:disable Layout/LineLength
                                                              category_ids: [service.category_id.to_s], # rubocop:disable Layout/LineLength
                                                              service_name: service.name,
                                                              company_name: service.company.name),
          headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
      expect(response).to have_http_status(:ok)
    end

    it 'responds bad request because page is required' do
      get(search_companies_with_filters_api_v1_companies_path,
          headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
      expect(response).to have_http_status(:bad_request)
    end
  end
end
