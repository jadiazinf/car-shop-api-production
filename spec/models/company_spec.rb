require 'rails_helper'

RSpec.describe Company do
  describe 'validations' do
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

    it 'validates presence of phonenumbers' do
      company.phonenumbers = nil
      expect(company).not_to be_valid
      expect(company.errors[:phonenumbers]).to include("can't be blank")
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

    it 'validates presence of payment_methods' do
      company.payment_methods = nil
      expect(company).not_to be_valid
      expect(company.errors[:payment_methods]).to include("can't be blank")
    end

    # TODO: hablarlo con Miguel. Validar el status de la petición, pero está fallando.
    # it 'validates inclusion of request_status' do
    #   company = Company.new(request_status: 'invalid_status')
    #   expect(company.valid?).to be_falsey
    #   expect(company.errors[:request_status]).to
    #   include(I18n.t('active_record.companies.errors.request_status.invalid'))
    # end
  end
end
