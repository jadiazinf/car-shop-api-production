require 'rails_helper'

RSpec.describe Quotes::CreateService do
  describe '#perform' do
    let(:quote) { build(:quote) }

    it 'creates quotes successfully with valid parameters' do
      result = described_class.new([quote.attributes.symbolize_keys]).perform
      expect(result).to eq([true, 'Quotes created successfully'])
    end

    it 'fails when required parameters are missing' do
      service = described_class.new([{}])
      result = service.perform
      expect(result.first).to be_falsey
    end

    it 'rolls back transactions if one quote fails' do
      service = described_class.new(partially_valid_params)
      expect { service.perform }.not_to change(Quote, :count)
    end

    it 'handles unexpected errors gracefully' do
      allow(Quote).to receive(:create!).and_raise(StandardError, 'Unexpected error')
      result = described_class.new([quote.attributes.symbolize_keys]).perform
      expect(result).to eq([false, 'An unexpected error occurred: Unexpected error'])
    end
  end

  private

  def partially_valid_params
    [
      valid_quote_params,
      invalid_quote_params
    ]
  end

  def valid_quote_params
    { service_cost: 100, date: Time.zone.now, note: 'Valid quote', status_by_company: 'pending',
      status_by_client: 'approved' }
  end

  def invalid_quote_params
    { note: 'Invalid quote', status_by_company: 'pending', status_by_client: 'approved' }
  end
end
