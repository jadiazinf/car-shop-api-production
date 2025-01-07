require 'rails_helper'

RSpec.describe Users::GenerateToken do
  let(:user) { create(:user, :registration) }
  let(:invalid_user_id) { -1 }
  let(:service) { described_class.new(user.id) }
  let(:invalid_service) { described_class.new(invalid_user_id) }

  describe '#perform' do
    context 'when the user exists' do
      it 'returns a valid JWT token' do
        token = service.perform
        expect(token).to be_a(String)
      end

      it 'contains the correct user_id in the payload' do
        token = service.perform
        decoded_payload = JWT.decode(token, Rails.application.credentials.jwt.secret)[0]
        expect(decoded_payload['id']).to eq(user.id)
      end

      it 'has a valid expiration timestamp' do
        token = service.perform
        decoded_payload = JWT.decode(token, Rails.application.credentials.jwt.secret)[0]
        expect(decoded_payload['exp']).to be > Time.now.to_i
      end
    end

    context 'when the user does not exist' do
      it 'returns nil' do
        token = invalid_service.perform
        expect(token).to be_nil
      end
    end
  end
end
