require 'rails_helper'

RSpec.describe Orders::GetUserOrders do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let!(:vehicle_a) { create(:vehicle) }
  let!(:vehicle_b) { create(:vehicle, user: vehicle_a.user) }
  let!(:vehicle_c) { create(:vehicle, user: vehicle_a.user) }
  let!(:order_a) { create(:order, vehicle: vehicle_a) } # rubocop:disable RSpec/LetSetup
  let!(:order_b) { create(:order, :unactive_order, vehicle: vehicle_a) } # rubocop:disable RSpec/LetSetup
  let!(:order_c) { create(:order, :finished_order, vehicle: vehicle_b) } # rubocop:disable RSpec/LetSetup
  let!(:order_d) { create(:order, :canceled_order, vehicle: vehicle_c) } # rubocop:disable RSpec/LetSetup

  context 'when there is no filters' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns all orders with' do
      result = described_class.new({ user_id: vehicle_a.user_id }).perform
      expect(result).to all(have_attributes(status: satisfy do |s|
                                                      %w[in_progress canceled
                                                         finished].include?(s)
                                                    end))
    end
  end

  context 'when is_active is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only orders where is active is false' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     is_active: false }).perform
      expect(result).to all(have_attributes(is_active: false))
    end

    it 'returns only orders where is active is true' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     is_active: true }).perform
      expect(result).to all(have_attributes(is_active: true))
    end
  end

  context 'when vehicle is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only orders where vehicle is the passed' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     vehicle_id: vehicle_a.id }).perform
      expect(result).to all(have_attributes(vehicle_id: vehicle_a.id))
    end
  end

  context 'when status is passed' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns only orders where status is in progress' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     status: 'in_progress' }).perform
      expect(result).to all(have_attributes(status: 'in_progress'))
    end

    it 'returns only orders where status is canceled' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     status: 'canceled' }).perform
      expect(result).to all(have_attributes(status: 'canceled'))
    end

    it 'returns only orders where status is finished' do
      result = described_class.new({ user_id: vehicle_a.user_id,
                                     status: 'finished' }).perform
      expect(result).to all(have_attributes(status: 'finished'))
    end
  end
end
