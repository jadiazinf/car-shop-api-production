require 'rails_helper'

RSpec.describe Orders::GetCompanyOrders do
  let!(:admin) { create(:user_company, :valid_admin) }
  let!(:order_a) { create(:order, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:order_b) { create(:order, :unactive_order, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:order_c) { create(:order, :finished_order, company: admin.company) } # rubocop:disable RSpec/LetSetup
  let!(:order_d) { create(:order, :canceled_order, company: admin.company) } # rubocop:disable RSpec/LetSetup

  context 'when there is no filters' do
    it 'returns all orders with' do
      result = described_class.new({ company_id: admin.company_id }).perform
      expect(result).to all(have_attributes(status: satisfy do |s|
                                                      %w[in_progress canceled
                                                         finished].include?(s)
                                                    end))
    end
  end

  context 'when is_active is passed' do
    it 'returns only orders where is active is false' do
      result = described_class.new({ company_id: admin.company_id,
                                     is_active: false }).perform
      expect(result).to all(have_attributes(is_active: false))
    end

    it 'returns only orders where is active is true' do
      result = described_class.new({ company_id: admin.company_id,
                                     is_active: true }).perform
      expect(result).to all(have_attributes(is_active: true))
    end
  end

  context 'when status is passed' do
    it 'returns only orders where status is in progress' do
      result = described_class.new({ company_id: admin.company_id,
                                     status: 'in_progress' }).perform
      expect(result).to all(have_attributes(status: 'in_progress'))
    end

    it 'returns only orders where status is canceled' do
      result = described_class.new({ company_id: admin.company_id,
                                     status: 'canceled' }).perform
      expect(result).to all(have_attributes(status: 'canceled'))
    end

    it 'returns only orders where status is finished' do
      result = described_class.new({ company_id: admin.company_id,
                                     status: 'finished' }).perform
      expect(result).to all(have_attributes(status: 'finished'))
    end
  end
end
