require 'rails_helper'

RSpec.describe Company do
  context 'when the attributes are incorrect' do
    let(:company) { described_class.new }

    it 'validates presence of name' do
      company.name = nil
      company.valid?
      expect(company.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      company.email = nil
      company.valid?
      expect(company.errors[:email]).to include("can't be blank")
    end

    it 'validates presence of address' do
      company.address = nil
      company.valid?
      expect(company.errors[:address]).to include("can't be blank")
    end

    it 'validates presence of location_id' do
      company.location_id = nil
      company.valid?
      expect(company).not_to be_valid
    end

    it 'validates presence of dni' do
      company.dni = nil
      company.valid?
      expect(company.errors[:dni]).to include("can't be blank")
    end
  end

  context 'when the attributes are correct' do
    let(:valid_company) { create(:company) }

    it 'creates an instance' do
      expect(valid_company.persisted?).to be true
    end
  end
end
