require 'jwt'

class Users::GenerateToken
  attr_accessor :secret_key, :user

  def initialize(user_id)
    @secret_key = Rails.application.credentials.jwt.secret
    @user = User.find_by(id: user_id)
  end

  def perform
    return nil if user.blank?

    payload = user.attributes.except('encrypted_password', 'reset_password_token',
                                     'reset_password_sent_at', 'remember_created_at')
    payload[:exp] = 1.day.from_now.to_i

    JWT.encode(payload, secret_key, 'HS256')
  end
end
