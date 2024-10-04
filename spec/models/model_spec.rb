require 'rails_helper'

RSpec.describe Model do
  context 'when the attributes are invalid' do
    let(:invalid_model) { build(:model, :invalid_model) }
    it 'Wrong value for name' do
      invalid_model.save
      errors = invalid_model.errors[:name]
      message = I18n.t('active_record.errors.general.blank')
      expect(errors.include?(message)).to be true
    end
  end

  context 'when the attributes are valid' do
    let(:valid_model) { build(:model, :valid_model) }
    it 'is valid' do
      expect(valid_model.valid?).to be true
    end
  end
end
