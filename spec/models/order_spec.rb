require 'rails_helper'

RSpec.describe Order do
  context 'when company creates a quote' do
    let(:order) { build(:order) }

    it 'creates a quote' do
      expect(order.valid?).to be true
    end
  end

  context 'when client creates a quote' do
    let(:order) { build(:order, :quote_created_by_user) }

    it 'creates a quote' do
      expect(order.valid?).to be true
    end
  end
end
