# require 'rails_helper'

# RSpec.describe Api::V1::UsersCompaniesRequestsController, type: :controller do
# let!(:company) { create(:company) }
# let!(:user) { create(:user, :with_valid_attr) }
# let!(:request) { create(:company_creation_request, company:, responder_user_id: user.id) }

# describe 'PATCH #update' do
#   context 'when the request is successful' do
#     let(:valid_params) do
#       {
#         status: 'approved',
#         company_id: company.id,
#         responder_user_id: user.id,
#         message: 'Request approved'
#       }
#     end

#     it 'updates the company creation request and returns a success message' do
#       patch :update, params: { id: request.id, company_creation_request: valid_params }
#       message = I18n.t('active_record.users_companies_requests.success.request_created')
#       expect(response).to have_http_status(:ok)
#       expect(response.parsed_body).to eq({ 'message' => message })
#     end
#   end

#   context 'when the request is not found' do
#     it 'returns a not found error' do
#       non_existent_id = -9999

#       patch :update, params: {
#         id: non_existent_id,
#         company_creation_request: FactoryBot.attributes_for(:company_creation_request,
#                                                             :approved_request)
#       }
#       message = "Couldn't find CompanyCreationRequest with 'id'=#{non_existent_id}"
#       expect(response).to have_http_status(:not_found)
#       expect(response.parsed_body).to include('error' => message)
#     end
#   end
# end
# end
