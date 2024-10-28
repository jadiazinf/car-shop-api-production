require 'rails_helper'

RSpec.describe Models::Create do
  let(:model) { build(:model, :invalid_model) }

  it 'Create model with invalid attributes' do
    service = described_class.new(model)
    result = service.handle
    expect(result[0]).to be false
  end

  context 'when the attributes are valid' do
    let(:brand) { create(:brand) }
    let(:model) { build(:model, brand_id: brand.id) }

    it 'Create model with valid attributes' do
      service = described_class.new(model)
      result = service.handle
      expect(result[0]).to be true
    end
  end
end
