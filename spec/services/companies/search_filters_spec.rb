require 'rails_helper'

RSpec.describe Companies::SearchFilters do
  let!(:service_a) { create(:service) }
  let!(:service_b) { create(:service) }
  let!(:service_c) { create(:service) }
  let(:params) do
    {
      company_name: service_a.company.name,
      service_name: service_a.name,
      category_ids: [service_a.category.id.to_s],
      location_id: service_a.company.location.parent_location_id,
      page: 1
    }
  end

  it 'returns companies' do
    companies = described_class.new(params).perform

    expect(companies).to be_a(ActiveRecord::Relation)
  end

  context 'when companies need to be filtered by service name' do
    it 'companies should be equal to service_a' do
      companies = described_class.new({ service_name: params[:service_name] }).perform
      expect(companies).to contain_exactly(service_a.company)
    end

    it 'companies should not include a service diferent to service_a' do
      companies = described_class.new({ service_name: params[:service_name] }).perform
      expect(companies).not_to include([service_b.company, service_c.company])
    end
  end

  context 'when companies need to be filtered by categories' do
    it 'companies should be equal to service_a' do
      companies = described_class.new({ category_ids: params[:category_ids] }).perform
      expect(companies).to contain_exactly(service_a.company)
    end

    it 'companies should not include a service diferent to service_a' do
      companies = described_class.new({ category_ids: params[:category_ids] }).perform
      expect(companies).not_to include([service_b.company, service_c.company])
    end
  end

  context 'when companies need to be filtered by company name' do
    it 'companies should be equal to service_a' do
      companies = described_class.new({ company_name: params[:company_name] }).perform
      expect(companies).to contain_exactly(service_a.company)
    end

    it 'companies should not include a service diferent to service_a' do
      companies = described_class.new({ company_name: params[:company_name] }).perform
      expect(companies).not_to include([service_b.company, service_c.company])
    end
  end

  context 'when companies need to be filtered by location' do
    it 'companies should be equal to service_a' do
      companies = described_class.new({ location_id: params[:location_id] }).perform
      expect(companies).to contain_exactly(service_a.company)
    end

    it 'companies should not include a service diferent to service_a' do
      companies = described_class.new({ location_id: params[:location_id] }).perform
      expect(companies).not_to include([service_b.company, service_c.company])
    end
  end
end
