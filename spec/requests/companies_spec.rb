require 'rails_helper'

RSpec.describe 'Companies' do
  let(:company) { build(:company) }
  let(:location) { create(:location) }
  let(:user) { create(:user, :registration) }

  describe 'POST #create' do
    let(:params) do
      {
        name: company.name,
        dni: company.dni,
        email: company.email,
        address: company.address,
        location_id: location.id,
        user_ids: [user.id],
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpeg')],
        user: user.attributes
      }
    end

    after do
      FileUtils.rm_rf(ActiveStorage::Blob.service.root) if ActiveStorage::Blob.service.root
    end

    it 'creates a new company' do
      headers = Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                      company.users.first)
      post(api_v1_companies_path,
           headers:, params:)
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
      patch(api_v1_company_path(id: admin.company_id),
            headers:, params:)
      expect(response).to have_http_status(:ok)
    end
  end
end
