require 'rails_helper'

RSpec.describe Category do
  context 'when the attributes are invalid' do
    let(:invalid_category) { build(:category, :invalid) }

    it 'is not valid' do
      expect(invalid_category.valid?).to be false
    end
  end

  context 'when the attributes are valid' do
    let(:category) { build(:category) }

    it 'is valid' do
      expect(category.valid?).to be true
    end
  end
end
