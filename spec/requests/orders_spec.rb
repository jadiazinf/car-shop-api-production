require 'rails_helper'

RSpec.describe 'Brands' do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:vehicle) { create(:vehicle) }
  let(:admin) { create(:user_company, :valid_admin) }
  let(:order_a) { create(:order, vehicle:) }
  let(:quote_a) { create(:order, :quote_created_by_company, vehicle:, company: order_a.company) }
  let(:order_b) { create(:order, vehicle:, company: order_a.company) }
  let(:order_c) { create(:order, vehicle:, company: order_a.company) }
  let(:order_d) { create(:order, vehicle:, company: order_a.company) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:admin_headers) { Devise::JWT::TestHelpers.auth_headers(headers, admin.user) }
  let(:user_headers) { Devise::JWT::TestHelpers.auth_headers(headers, vehicle.user) }

  describe 'GET #company_orders' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a success response' do
      get(company_orders_api_v1_orders_path(company_id: order_a.company_id), headers: admin_headers)
      expect(response).to be_successful
    end
  end

  describe 'GET #company_quotes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a success response' do
      get(company_quotes_api_v1_orders_path(company_id: order_a.company_id), headers: admin_headers)
      expect(response).to be_successful
    end
  end

  describe 'GET #user_orders' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a success response' do
      get(user_orders_api_v1_orders_path(user_id: vehicle.user_id), headers: user_headers)
      expect(response).to be_successful
    end
  end

  describe 'GET #user_quotes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a success response' do
      get(user_quotes_api_v1_orders_path(user_id: vehicle.user_id), headers: user_headers)
      expect(response).to be_successful
    end
  end
end
