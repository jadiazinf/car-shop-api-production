require 'rails_helper'

RSpec.describe Brand do
  context 'when the attributes are invalid' do
    let(:invalid_brand) { build(:brand, :invalid_brand) }

    it 'Wrong value for name' do
      invalid_brand.save
      errors = invalid_brand.errors[:name]
      message = I18n.t('active_record.errors.general.blank')
      expect(errors.include?(message)).to be true
    end
  end

  context 'when the attributes are valid' do
    let(:brand) { build(:brand) }

    it 'is valid' do
      expect(brand.valid?).to be true
    end
  end
end
