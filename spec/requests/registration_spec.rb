require 'rails_helper'

RSpec.describe 'Users' do
  describe 'POST #create' do
    let(:location) { create(:location, :valid_town) }

    let(:user_attributes) { attributes_for(:user, :registration).merge(location_id: location.id) }
    it 'returns a success response' do
      post(user_registration_path,
           params: { user: user_attributes }, headers: {}, as: :json)

      expect(response).to be_successful
    end
  end
end
