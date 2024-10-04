require 'rails_helper'

RSpec.describe 'Companies' do
  context 'Companies requests' do
    let(:company) { build(:company) }
    let(:location) { create(:location, :valid_town) }
    let(:user) { create(:user, :registration) }
    let!(:headers) { { 'Accept' => 'application/json' } }
    let!(:auth_headers) do
      Devise::JWT::TestHelpers.auth_headers(headers, user)
    end

    context 'POST #create' do
      context 'with valid params' do
        let(:params) do
          {
            company: {
              name: company.name,
              dni: company.dni,
              email: company.email,
              address: company.address,
              location_id: location.id,
              user_ids: [user.id],
              company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
              company_images: [fixture_file_upload('image.jpg', 'image/jpeg')]
            },
            user: user.attributes
          }
        end

        it 'creates a new company' do
          post(api_v1_companies_path, headers: auth_headers, params:)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'PUT #update' do
      let(:admin) { create(:user_company, :valid_admin) }
      let!(:auth_headers) do
        Devise::JWT::TestHelpers.auth_headers(headers, admin.user)
      end

      it 'updates a company' do
        patch(
          api_v1_company_path(id: admin.company_id),
          headers: auth_headers,
          params: { company: {
            name: 'New Name',
            company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
            company_images: [fixture_file_upload('image.jpg', 'image/jpeg')]
          }, company_id: admin.company_id }
        )
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
