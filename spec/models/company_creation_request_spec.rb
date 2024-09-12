require 'rails_helper'

RSpec.describe CompanyCreationRequest, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = CompanyCreationRequest.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:optional]).to be true
    end

    it 'belongs to company' do
      association = CompanyCreationRequest.reflect_on_association(:company)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:optional]).to be_nil
    end
  end

  describe 'validations' do
    it 'validates presence of status' do
      request = CompanyCreationRequest.new(status: nil)
      expect(request).not_to be_valid
      message = I18n.t('active_record.company_creation_requests.errors.status_required')
      expect(request.errors[:status]).to include(message)
    end

    it 'validates presence of company' do
      request = CompanyCreationRequest.new(status: 'pending', company: nil)
      expect(request).not_to be_valid
      message = I18n.t('active_record.company_creation_requests.errors.company_id_required')
      expect(request.errors[:company]).to include(message)
    end

    it 'is valid with a status and company' do
      company = create(:company)
      request = CompanyCreationRequest.new(status: 'pending', company:)
      expect(request).to be_valid
    end
  end

  describe 'default values' do
    it 'has a default status of pending' do
      request = create(:company_creation_request)
      expect(request.status).to eq('pending')
    end
  end
end
