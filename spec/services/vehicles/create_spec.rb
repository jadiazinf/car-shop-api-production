require 'rails_helper'

RSpec.describe Vehicles::Create do
  let(:invalid_vehicle) { build(:vehicle, :invalid).attributes }
  it 'Create vehicle with invalid attributes' do
    service = Vehicles::Create.new(invalid_vehicle)
    result = service.perform
    expect(result[0]).to be false
  end

  context 'when the attributes are valid' do
    let(:brand) { create(:brand, :valid_brand) }
    let(:model) { create(:model, :valid_model, brand_id: brand.id) }
    let(:user) { create(:user, :with_valid_attr) }
    let(:vehicle) { build(:vehicle, user:, model:).attributes }
    it 'Create vehicle with valid attributes' do
      service = Vehicles::Create.new(vehicle)
      result = service.perform
      expect(result[0]).to be true
    end
  end
end
