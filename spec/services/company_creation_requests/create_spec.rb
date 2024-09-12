require 'rails_helper'

RSpec.describe CompanyCreationRequests::Create do
  let(:valid_params) { { company_id: 1 } }
  let(:invalid_params) { { company_id: nil } }

  describe '#perform' do
    context 'when params are valid' do
      it 'creates a new CompanyCreationRequest' do
        request_double = instance_double(CompanyCreationRequest, save: true)
        allow(CompanyCreationRequest).to receive(:new).and_return(request_double)

        service = CompanyCreationRequests::Create.new(valid_params)
        result = service.perform

        expect(result[:success]).to be true
        expect(result[:request]).to eq(request_double) # Comprobar el objeto correcto
      end
    end

    context 'when params are invalid' do
      it 'returns an error when company_id is not provided' do
        message = I18n.t('active_record.company_creation_requests.errors.company_id_required')
        expect do
          CompanyCreationRequests::Create.new(invalid_params)
        end.to raise_error(ArgumentError, message)
      end

      it 'returns errors when the request fails to save' do
        full_messages = ['Error saving request']
        request_double = instance_double(CompanyCreationRequest, save: false,
                                                                 errors: double(full_messages:))
        allow(CompanyCreationRequest).to receive(:new).and_return(request_double)

        service = CompanyCreationRequests::Create.new(valid_params)
        result = service.perform

        expect(result[:success]).to be false
        expect(result[:errors]).to include('Error saving request')
      end
    end

    context 'when an exception is raised' do
      it 'returns an error message' do
        allow(CompanyCreationRequest).to receive(:new)
          .and_raise(StandardError.new('Unexpected error'))

        service = CompanyCreationRequests::Create.new(valid_params)
        result = service.perform

        expect(result[:success]).to be false
        expect(result[:error]).to eq('Unexpected error')
      end
    end
  end
end
