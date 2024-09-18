require 'rails_helper'

RSpec.describe Companies::Create do
  let(:valid_params) { build(:company) }
  context 'with invalid attributes' do
    it 'errors should not be empty' do
      create_service = Companies::Create.new({})
      result = create_service.perform
      expect(result[:errors]).not_to be_empty
    end

    context 'with invalid files' do
      let(:with_invalid_company_charter) do
        {
          name: valid_params[:name],
          dni: valid_params[:dni],
          email: valid_params[:email],
          address: valid_params[:address],
          location: create(:location, :valid_town),
          users: [create(:user, :with_valid_attr)],
          company_charter: fixture_file_upload('image.jpg', 'image/jpg'),
          company_images: [fixture_file_upload('image.jpg', 'image/jpg')]
        }
      end

      it 'errors should be for company charter' do
        create_service = Companies::Create.new(with_invalid_company_charter)
        result = create_service.perform
        expect(result[:errors]).not_to be_empty
      end

      let(:with_invalid_images) do
        {
          name: valid_params[:name],
          dni: valid_params[:dni],
          email: valid_params[:email],
          address: valid_params[:address],
          location: create(:location, :valid_town),
          users: [create(:user, :with_valid_attr)],
          company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
          company_images: [fixture_file_upload('company_charter.pdf', 'application/pdf')]
        }
      end
      it 'errors should be for company images' do
        create_service = Companies::Create.new(with_invalid_images)
        result = create_service.perform
        expect(result[:errors]).not_to be_empty
      end
    end
  end

  context 'with valid attributes' do
    let(:params) do
      {
        name: valid_params[:name],
        dni: valid_params[:dni],
        email: valid_params[:email],
        address: valid_params[:address],
        location: create(:location, :valid_town),
        users: [create(:user, :with_valid_attr)],
        company_charter: fixture_file_upload('company_charter.pdf', 'application/pdf'),
        company_images: [fixture_file_upload('image.jpg', 'image/jpg')]
      }
    end
    it 'ok should be true' do
      create_service = Companies::Create.new(params)
      result = create_service.perform
      expect(result[:ok]).to be true
    end
  end
end
