require 'rails_helper'

RSpec.describe Vehicles::Create do
  context 'when the attributes are invalid' do
    let(:invalid_vehicle) { build(:vehicle, :invalid).attributes }

    it 'Return false when vehicle have invalid attributes' do
      service = described_class.new(invalid_vehicle)
      result = service.perform
      expect(result[0]).to be false
    end
  end

  context 'when the attributes are valid' do
    let(:vehicle) { build(:vehicle) }

    it 'Create vehicle with valid attributes' do
      service = described_class.new(vehicle.attributes.merge(vehicle_images: [fixture_file_upload(
        'image.jpg', 'image/jpeg'
      )]))
      result = service.perform
      expect(result[0]).to be true
    end
  end
end
