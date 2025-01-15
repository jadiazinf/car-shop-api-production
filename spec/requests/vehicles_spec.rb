require 'rails_helper'
RSpec.describe 'Vehicles' do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'POST #create' do
    let(:vehicle_params) { build(:vehicle) }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, vehicle_params.user) }

    it 'returns a created http status response' do
      post(api_v1_vehicles_path,
           headers: auth_headers,
           params: { vehicle: vehicle_params.attributes.merge(model_id: vehicle_params.model.id) },
           as: :json)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH #attach_images' do
    let(:vehicle) { create(:vehicle) }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, vehicle.user) }

    it 'returns a ok http status response' do
      patch(attach_images_api_v1_vehicle_path(vehicle),
            headers: auth_headers,
            params: { vehicle_images: [fixture_file_upload('image.jpg', 'image/jpg')] })
      expect(response).to have_http_status(:ok)
    end
  end
end
