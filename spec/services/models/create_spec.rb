require 'rails_helper'

RSpec.describe Models::Create do
  let(:model) { build(:model, :invalid_model) }
  it 'Create model with invalid attributes' do
    service = Models::Create.new(model)
    result = service.handle
    expect(result[0]).to be false
  end

  context 'when the attributes are valid' do
    let(:brand) { create(:brand, :valid_brand) }
    let(:model) { build(:model, :valid_model, brand_id: brand.id) }
    it 'Create model with valid attributes' do
      service = Models::Create.new(model)
      result = service.handle
      expect(result[0]).to be true
    end
  end
end
