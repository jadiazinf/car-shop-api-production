require 'rails_helper'

RSpec.describe Company do
  context 'attribute validations' do
    let(:company) { Company.new }

    it 'validates presence of name' do
      company.name = nil
      expect(company).not_to be_valid
      expect(company.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      company.email = nil
      expect(company).not_to be_valid
      expect(company.errors[:email]).to include("can't be blank")
    end

    it 'validates presence of address' do
      company.address = nil
      expect(company).not_to be_valid
      expect(company.errors[:address]).to include("can't be blank")
    end

    it 'validates presence of location_id' do
      company.location_id = nil
      expect(company).not_to be_valid
    end

    it 'validates presence of company_charter' do
      company.company_charter = nil
      expect(company).not_to be_valid
      expect(company.errors[:company_charter]).to include("can't be blank")
    end

    it 'validates presence of dni' do
      company.dni = nil
      expect(company).not_to be_valid
      expect(company.errors[:dni]).to include("can't be blank")
    end
  end

  context 'create company' do
    let(:valid_company) { build(:company) }
    it 'creates an instance' do
      expect(valid_company.valid?).to be true
    end
  end
end
