require 'rails_helper'

RSpec.describe Vehicle do
  context 'when the attributes are invalid' do
    let(:invalid_vehicle) { build(:vehicle, :invalid) }

    it 'throw errors' do
      expect(invalid_vehicle).not_to be_valid
    end
  end

  context 'when the attributes are valid' do
    let(:model) { create(:model) }
    let(:user) { create(:user, :with_valid_attr) }
    let(:vehicle) do
      build(:vehicle, user:, model:,
                      vehicle_images: [fixture_file_upload('image.jpg', 'image/jpeg')])
    end

    it 'is valid' do
      expect(vehicle.valid?).to be true
    end
  end
end
