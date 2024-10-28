require 'rails_helper'

RSpec.describe Service do
  context 'when the attributes are invalid' do
    let(:service) { build(:service, :invalid_service) }

    it 'has errors' do
      service.save
      expect(service.errors).not_to be_empty
    end
  end

  context 'when the attributes are valid' do
    let(:service) { build(:service) }

    it 'saves correctly' do
      service.save
      expect(service.errors).to be_empty
    end
  end
end
