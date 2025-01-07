require 'rails_helper'

RSpec.describe 'UsersCompanies' do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:admin) { create(:user_company, :valid_admin) }
  let(:technical) { create(:user_company, :valid_technical) }
  let(:technical_params) do
    {
      id: technical.id,
      company_id: technical.company_id,
      user_id: technical.user_id,
      page: 1,
      headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                     technical.user)
    }
  end

  let(:admin_params) do
    {
      id: admin.id,
      company_id: admin.company_id,
      user_id: admin.user_id,
      page: 1,
      headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                     admin.user)
    }
  end

  describe '#POST' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:admin_attr) { build(:user_company, :valid_admin) }

    it 'returns http status created when valid attributes' do
      post(api_v1_users_companies_path,
           headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                          admin.user),
           params: { user_company: admin_attr.attributes })
      expect(response).to have_http_status(:created)
    end

    it 'returns http status bad request when invalid attributes' do
      post(api_v1_users_companies_path,
           headers: Devise::JWT::TestHelpers.auth_headers({ 'Accept' => 'application/json' },
                                                          admin.user),
           params: { user_company: { quems: 1 } })
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET #admin' do
    it 'returns http status 200' do
      get(admin_api_v1_users_company_path(admin.id), headers:)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #company_users' do
    it 'returns http status forbbiden when its not admin' do # rubocop:disable RSpec/ExampleLength
      get(
        company_users_api_v1_users_companies_path(company_id: technical_params[:company_id],
                                                  page: technical_params[:page]),
        headers: technical_params[:headers]
      )
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns http status ok when its admin' do # rubocop:disable RSpec/ExampleLength
      get(
        company_users_api_v1_users_companies_path(company_id: admin_params[:company_id],
                                                  page: admin_params[:page]),
        headers: admin_params[:headers]
      )
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #toggle_active' do
    it 'returns http status forbbiden when its not admin' do # rubocop:disable RSpec/ExampleLength
      put(
        toggle_active_api_v1_users_company_path(id: technical_params[:id],
                                                user_company_id: technical_params[:id],
                                                company_id: technical_params[:company_id]),
        headers: technical_params[:headers]
      )
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns http status ok when its admin' do # rubocop:disable RSpec/ExampleLength
      put(
        toggle_active_api_v1_users_company_path(id: admin_params[:id],
                                                user_company_id: admin_params[:id],
                                                company_id: admin_params[:company_id]),
        headers: admin_params[:headers]
      )
      expect(response).to have_http_status(:ok)
    end
  end
end
