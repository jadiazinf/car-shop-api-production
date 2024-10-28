require 'rails_helper'

RSpec.describe 'Services' do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'GET #index' do
    it 'returns a list with services paginated' do
      get(api_v1_services_path, headers:, params: { page: 10 })
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
end
