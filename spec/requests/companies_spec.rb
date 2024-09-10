require 'rails_helper'

RSpec.describe 'Companies' do
  describe 'POST #create' do
    let(:company) { create(:company) }
    let(:invalid_attributes) { build(:company, :invalid_company) }
    let!(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

    context 'with valid attributes' do
      it 'creates a new company' do
        post(api_v1_companies_path,
             params: {
               company:
             }.to_json,
             headers:)

        expect(response).to have_http_status(:ok)
      end
    end

    # TODO: preguntarle a miguel por que esta pedazo de mierda no sirv por los malditos atributos del coño
    context 'with invalid attributes' do
      it 'does not create a new company' do
        post(api_v1_companies_path,
             params: {
               company: invalid_attributes
             }.to_json,
             headers:)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
