require 'rails_helper'

RSpec.describe UsersCompaniesRequests::Update do
  let(:request) { build(:user_company_request) }

  context 'with invalid params' do
    let(:invalid_request) { build(:user_company_request, :invalid_request) }

    it 'throws error' do
      expect do
        described_class.new(invalid_request.attributes)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'with valid params' do
    let(:pending_request) { create(:user_company_request, :pending_request) }

    context 'when a pending request is rejected' do
      let(:params) do
        {
          responder_user_id: create(:user_company, :valid_superadmin).user_id,
          id: pending_request.id,
          status: 'rejected',
          message: 'Rejected'
        }
      end

      it 'company attribute is_active should be false' do
        described_class.new(params.with_indifferent_access).perform
        pending_request.reload
        expect(pending_request.company.is_active).to be false
      end
    end

    context 'with aprroved request' do
      let(:params) do
        {
          responder_user_id: create(:user_company, :valid_superadmin).user_id,
          id: pending_request.id,
          status: 'approved',
          message: 'approved'
        }
      end

      it 'company attribute is_active should be true' do
        described_class.new(params.with_indifferent_access).perform
        pending_request.reload
        expect(pending_request.company.is_active).to be true
      end
    end
  end
end
