require 'rails_helper'

RSpec.describe Orders::GetUserQuotes do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let!(:company) { create(:company, :active_company) } # rubocop:disable RSpec/LetSetup
  let!(:quote_a) { create(:order, :quote_created_by_user) }
  let!(:quote_b) { create(:order, :quote_created_by_user, vehicle: quote_a.vehicle) } # rubocop:disable RSpec/LetSetup
  let!(:quote_c) { create(:order, :quote_created_by_user, vehicle: quote_a.vehicle) } # rubocop:disable RSpec/LetSetup
  let!(:quote_d) do # rubocop:disable RSpec/LetSetup
    create(:order, :quote_created_by_user, is_active: false, vehicle: quote_a.vehicle)
  end
  let!(:quote_e) do # rubocop:disable RSpec/LetSetup
    create(:order, :quote_created_by_user, is_active: false)
  end

  context 'when there is no filters' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns all orders with status equals to quote' do
      result = described_class.new({ status: 'quote', user_id: quote_a.vehicle.user_id }).perform
      expect(result.empty?).to be false
    end
  end

  context 'when is_checked is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only unchecked orders and status is quote' do
      result = described_class.new({ status: 'quote', user_id: quote_a.vehicle.user_id,
                                     is_checked: false }).perform
      expect(result).to all(have_attributes(is_checked: false))
    end

    it 'returns only checked orders and status is quote' do
      result = described_class.new({ status: 'quote', user_id: quote_a.vehicle.user_id,
                                     is_checked: true }).perform
      expect(result).to all(have_attributes(is_checked: true))
    end
  end

  context 'when is_active is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only orders where is active is false and status is quote' do
      result = described_class.new({ status: 'quote', user_id: quote_a.vehicle.user_id,
                                     is_active: false }).perform
      expect(result).to all(have_attributes(is_active: false))
    end

    it 'returns only orders where is active is true and status is quote' do
      result = described_class.new({ status: 'quote', user_id: quote_a.vehicle.user_id,
                                     vehicle_id: quote_a.vehicle_id, is_active: true }).perform
      expect(result).to all(have_attributes(is_active: true))
    end
  end

  context 'when vehicle_id is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only orders where vehicle is the passed' do
      result = described_class.new({ user_id: quote_a.vehicle.user_id,
                                     vehicle_id: quote_a.vehicle_id }).perform
      expect(result).to all(have_attributes(vehicle_id: quote_a.vehicle_id))
    end
  end
end
