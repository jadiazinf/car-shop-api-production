require 'rails_helper'

RSpec.describe Companies::Update do
  let(:valid_params) { create(:company, :with_valid_files) }
  context 'with invalid attributes' do
    it 'errors should not be empty' do
      update_service = Companies::Update.new({})
      result = update_service.perform
      expect(result[:errors]).not_to be_empty
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
          company_images: [fixture_file_upload('image.jpg', 'image/jpg')]
        }
      end

      it 'errors should be for company charter' do
        update_service = Companies::Update.new(with_invalid_company_charter)
        result = update_service.perform
        expect(result[:errors]).not_to be_empty
      end

      let(:with_invalid_images) do
        {
          id: valid_params[:id],
          name: valid_params[:name],
          dni: valid_params[:dni],
          email: valid_params[:email],
          address: valid_params[:address],
          company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
          company_images: [fixture_file_upload('company_charter.pdf', 'application/pdf')]
        }
      end
      it 'errors should be for company images' do
        update_service = Companies::Update.new(with_invalid_images)
        result = update_service.perform
        expect(result[:errors]).not_to be_empty
      end
    end
  end

  context 'with valid attributes' do
    let(:params) do
      {
        id: valid_params[:id],
        name: valid_params[:name],
        dni: valid_params[:dni],
        email: valid_params[:email],
        address: valid_params[:address],
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpg')]
      }
    end
    it 'ok should be true' do
      update_service = Companies::Update.new(params)
      result = update_service.perform
      expect(result[:ok]).to be true
    end
  end
end
