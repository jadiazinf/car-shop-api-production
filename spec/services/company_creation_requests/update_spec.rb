require 'rails_helper'

RSpec.describe CompanyCreationRequests::Update do
  let(:company) { create(:company) }
  let(:user) { create(:user, :with_valid_attr) } # Usa el trait para crear un usuario válido
  let(:valid_request) do
    create(:company_creation_request, :approved_request, company:, responder_user_id: user.id)
  end

  let(:valid_params) do
    {
      id: valid_request.id,
      company_id: company.id,
      responder_user_id: user.id, # Asegúrate de usar el ID del usuario creado
      status: 'approved',
      message: 'Request approved'
    }
  end

  let(:invalid_params) do
    { id: nil, company_id: nil, responder_user_id: nil, status: nil, message: nil }
  end

  describe '#initialize' do
    context 'when parameters are valid' do
      it 'does not raise an error' do
        expect { CompanyCreationRequests::Update.new(valid_params) }.not_to raise_error
      end
    end

    context 'when parameters are invalid' do
      it 'raises an error when id is not provided' do
        expect { CompanyCreationRequests::Update.new(invalid_params) }
          .to raise_error(ArgumentError, I18n.t('active_record.errors.general.id_is_required'))
      end

      it 'raises an error when company_id is not provided' do
        invalid_params[:id] = 1
        message = I18n.t('active_record.company_creation_requests.errors.company_id_required')
        expect { CompanyCreationRequests::Update.new(invalid_params) }
          .to raise_error(ArgumentError, message)
      end

      it 'raises an error when responder_user_id is not provided' do
        invalid_params[:id] = 1
        invalid_params[:company_id] = company.id
        message = I18n.t('active_record.company_creation_requests.errors.responder_id_required')
        expect { CompanyCreationRequests::Update.new(invalid_params) }
          .to raise_error(ArgumentError, message)
      end

      it 'raises an error when status is not provided' do
        invalid_params[:id] = 1
        invalid_params[:company_id] = company.id
        invalid_params[:responder_user_id] = 1
        expect { CompanyCreationRequests::Update.new(invalid_params) }
          .to raise_error(ArgumentError,
                          I18n.t('active_record.company_creation_requests.errors.status_required'))
      end

      it 'raises an error when message is not provided' do
        invalid_params[:id] = 1
        invalid_params[:company_id] = company.id
        invalid_params[:responder_user_id] = 1
        invalid_params[:status] = 'approved'
        expect { CompanyCreationRequests::Update.new(invalid_params) }
          .to raise_error(ArgumentError,
                          I18n.t('active_record.company_creation_requests.errors.message_required'))
      end
    end
  end

  describe '#perform' do
    let(:service) { CompanyCreationRequests::Update.new(valid_params) }

    before do
      allow(CompanyCreationRequest).to receive(:find).with(valid_params[:id])
        .and_return(valid_request)
      allow(Company).to receive(:find).with(company.id).and_return(company)
    end

    context 'when the request is approved' do
      it 'activates the company' do
        expect(company).to receive(:update!).with(is_active: true)

        service.perform
      end
    end

    context 'when the request is not approved' do
      before do
        valid_request.update(status: 'pending')
        valid_params[:status] = 'pending'
      end

      it 'does not activate the company' do
        expect(company).not_to receive(:update!)

        service.perform
      end
    end

    context 'when a record is not found' do
      it 'handles ActiveRecord::RecordNotFound error' do
        allow(CompanyCreationRequest).to receive(:find).with(valid_params[:id])
          .and_raise(ActiveRecord::RecordNotFound)

        expect { service.perform }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when a validation error occurs' do
      it 'handles ActiveRecord::RecordInvalid error' do
        allow(valid_request).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)

        expect { service.perform }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
