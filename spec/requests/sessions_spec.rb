require 'rails_helper'
RSpec.describe 'Users' do
  let(:user) { create(:user, :with_valid_attr) }
  describe 'POST #create' do
    it 'returns a success response' do
      post(user_session_path, params: { user: { email: user.email, password: user.password } })
      expect(response).to be_successful
    end
  end
end
