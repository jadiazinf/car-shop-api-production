require 'rails_helper'

RSpec.describe 'Locations' do
  let!(:location) { create(:location) }
  let!(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let!(:superadmin) { create(:user_company, :valid_superadmin) }
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, superadmin.user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get(api_v1_locations_path, headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #location_childrens' do
    it 'returns a success response' do
      get(location_childrens_api_v1_location_path(location), headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #location_by_type' do
    it 'returns a success response' do
      get(location_by_type_api_v1_locations_path(location), headers:)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(api_v1_location_path(location), headers:)
      expect(response).to be_successful
    end
  end

  describe 'POST #create.rb' do
    let(:location) { build(:location) }
    it 'returns a success response' do
      post(api_v1_locations_path,
           params: { location: location.attributes }, headers:, as: :json)
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:location) { create(:location) }
    let(:new_location) { build(:location) }
    it 'returns a success response' do
      put(api_v1_location_path(location.id),
          params: { location: { id: location.id, new_location.attributes => true } },
          headers:, as: :json)
      expect(response).to be_successful
    end
  end

  describe 'PUT #toggle_active to false' do
    let(:location) { create(:location, is_active: true) }
    it 'returns a success response' do
      put(toggle_active_api_v1_location_path(location),
          params: { location: { id: location.id, active: false } }, headers:, as: :json)
      expect(response).to be_successful
    end
  end

  describe 'PUT #toggle_active to true' do
    let(:location) { create(:location, is_active: false) }
    it 'returns a success response' do
      put(toggle_active_api_v1_location_path(location),
          params: { location: { id: location.id, active: true } }, headers:, as: :json)
      expect(response).to be_successful
    end
  end
end
