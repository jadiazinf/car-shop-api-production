require 'rails_helper'
RSpec.describe 'Users' do
  let(:user) { attributes_for(:user, :registration) }
  describe 'POST #create.rb' do
    it 'returns a success response' do
      post(user_registration_path,
           params: { user: }, headers: {}, as: :json)
      expect(response).to be_successful
    end
  end
end
