require 'rails_helper'

RSpec.describe Brands::Create do
  context 'when the attributes are not valid' do
    let(:brand) { build(:brand, :invalid_brand) }
    it 'Create model' do
      create_service = Brands::Create.new(brand.name)
      result = create_service.perform
      expect(result[0]).to be false
    end
  end
  context 'with valid attributes' do
    let(:brand) { build(:brand, :valid_brand) }
    it 'Create model' do
      create_service = Brands::Create.new(brand.name)
      result = create_service.perform
      expect(result[0]).to be true
    end
  end
end
