require 'rails_helper'

RSpec.describe UsersCompanies::GetCompanyUsersFilter do
  let(:user_company) { create(:user_company, :valid_admin) }
  let(:expected_result) do
    {
      id: user_company.id,
      roles: user_company.roles,
      is_active: user_company.is_active,
      user_id: user_company.user_id,
      company_id: user_company.company_id,
      user: user_company.user.attributes.symbolize_keys
    }
  end

  describe '#perform' do
    context 'when name is passed' do
      it 'returns the users with the name' do
        service = described_class.new(name: user_company.user.first_name[0, 2],
                                      company_id: user_company.company_id,
                                      page: 1)
        result = service.perform

        expect(result).to include(expected_result)
      end

      it 'returns an empty array when there is no match with the passed name' do
        service = described_class.new(name: 'not a name at all',
                                      company_id: user_company.company_id,
                                      page: 1)
        result = service.perform
        expect(result).to be_empty
      end
    end

    context 'when name is not passed' do
      it 'returns an array with users' do
        service = described_class.new(company_id: user_company.company_id,
                                      page: 1)
        result = service.perform

        expect(result).to include(expected_result)
      end
    end
  end
end
