require 'rails_helper'

RSpec.describe 'Companies' do
  describe 'POST /api/v1/companies' do
    let(:company) { build(:company) }
    let(:location) { create(:location, :valid_town) }
    let(:user) { create(:user, :with_valid_attr, roles: ['admin']) }
    let!(:headers) { { 'Accept' => 'application/json' } }
    let!(:auth_headers) do
      Devise::JWT::TestHelpers.auth_headers(headers, user)
    end

    context 'with valid params' do
      let(:params) do
        {
          company: {
            name: company.name,
            dni: company.dni,
            email: company.email,
            address: company.address,
            location_id: location.id,
            user_id: user.id,
            company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
            company_images: [fixture_file_upload('image.jpg', 'image/jpeg')]
          }
        }
      end

      let(:company_to_update) { create(:company, :with_valid_files) }

      it 'creates a new company' do
        post(api_v1_companies_path, headers: auth_headers, params:)
        expect(response).to have_http_status(:created)
      end

      it 'updates a company' do
        patch(
          api_v1_company_path(id: company_to_update.id),
          headers: auth_headers,
          params: { company: {
            name: 'New Name',
            company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
            company_images: [fixture_file_upload('image.jpg', 'image/jpeg')]
          } }
        )
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
