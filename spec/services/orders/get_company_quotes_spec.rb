require 'rails_helper'

RSpec.describe Orders::GetCompanyQuotes do
  let!(:admin) { create(:user_company, :valid_admin) }
  let!(:quote_a) { create(:order, :quote_created_by_company, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:quote_b) { create(:order, :quote_created_by_company, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:quote_c) { create(:order, :quote_created_by_company, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:quote_d) do # rubocop:disable RSpec/LetSetup
    create(:order, :quote_created_by_company, company: admin.company, is_active: false)
  end

  context 'when there is no filters' do
    it 'returns all orders with status equals to quote' do
      result = described_class.new({ status: 'quote', company_id: admin.company_id }).perform
      expect(result.empty?).to be false
    end
  end

  context 'when is_checked is passed' do
    it 'returns only unchecked orders and status is quote' do
      result = described_class.new({ status: 'quote', company_id: admin.company_id,
                                     is_checked: false }).perform
      expect(result).to all(have_attributes(is_checked: false))
    end

    it 'returns only checked orders and status is quote' do
      result = described_class.new({ status: 'quote', company_id: admin.company_id,
                                     is_checked: true }).perform
      expect(result).to all(have_attributes(is_checked: true))
    end
  end

  context 'when is_active is passed' do
    it 'returns only orders where is active is false and status is quote' do
      result = described_class.new({ status: 'quote', company_id: admin.company_id,
                                     is_active: false }).perform
      expect(result.length == 1).to be true
    end

    it 'returns only orders where is active is true and status is quote' do
      result = described_class.new({ status: 'quote', company_id: admin.company_id,
                                     is_active: true }).perform
      expect(result).to all(have_attributes(is_active: true))
    end
  end
end
