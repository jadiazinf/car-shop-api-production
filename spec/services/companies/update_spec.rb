require 'rails_helper'

RSpec.describe Companies::Update do
  let(:valid_params) { create(:company) }
  let(:user_company) { create(:user_company, :valid_admin) }

  context 'with invalid attributes' do
    it 'errors should not be empty' do
      update_service = described_class.new({ user: user_company.user,
                                             company: user_company.company, dni: nil })
      result = update_service.perform
      expect(result[:ok]).to be false
    end
  end

  context 'with invalid files' do
    let(:with_invalid_company_charter) do
      {
        id: valid_params[:id],
        name: valid_params[:name],
        dni: valid_params[:dni],
        email: valid_params[:email],
        address: valid_params[:address],
        company_charter: fixture_file_upload('image.jpg', 'image/jpg'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpg')],
        user: user_company.user,
        company: user_company.company
      }
    end

    after do
      FileUtils.rm_rf(ActiveStorage::Blob.service.root) if ActiveStorage::Blob.service.root
    end

    it 'errors should be for company charter' do
      update_service = described_class.new(with_invalid_company_charter)
      result = update_service.perform
      expect(result[:errors]).not_to be_empty
    end
  end

  context 'with invalid images' do
    let(:with_invalid_images) do
      {
        id: valid_params[:id],
        name: valid_params[:name],
        dni: valid_params[:dni],
        email: valid_params[:email],
        address: valid_params[:address],
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('company_charter.pdf', 'application/pdf')],
        user: user_company.user,
        company: user_company.company
      }
    end

    after do
      FileUtils.rm_rf(ActiveStorage::Blob.service.root) if ActiveStorage::Blob.service.root
    end

    it 'errors should be for company images' do
      update_service = described_class.new(with_invalid_images)
      result = update_service.perform
      expect(result[:errors]).not_to be_empty
    end
  end

  context 'with valid attributes' do
    let(:valid) { create(:company) }
    let(:params) do
      {
        name: 'otro nombre',
        address: valid[:address],
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpg')],
        user: user_company.user,
        company: user_company.company
      }
    end

    after do
      FileUtils.rm_rf(ActiveStorage::Blob.service.root) if ActiveStorage::Blob.service.root
    end

    it 'ok should be true' do
      update_service = described_class.new(params)
      result = update_service.perform
      expect(result[:ok]).to be true
    end
  end
end
