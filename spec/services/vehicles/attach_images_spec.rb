require 'rails_helper'

RSpec.describe Vehicles::AttachImages do
  let(:vehicle) { create(:vehicle) }
  let(:valid_image) { fixture_file_upload('image.jpg', 'image/jpg') }

  context 'with valid attributes' do
    it 'returns true in the first element of the response' do
      attach_images_service = described_class.new(id: vehicle.id,
                                                  images: [valid_image])
      result = attach_images_service.perform
      expect(result[0]).to be_truthy
    end

    it 'returns true in the first element of the response even when the arr images is empty' do
      attach_images_service = described_class.new(id: vehicle.id,
                                                  images: [])
      result = attach_images_service.perform
      expect(result[0]).to be_truthy
    end
  end
end
