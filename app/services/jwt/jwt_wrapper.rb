class JWTWrapper
  def self.decode(token)
    secret_key = Rails.application.credentials.jwt.secret

    begin
      decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
      decoded_token.first
    rescue JWT::DecodeError
      nil
    end
  end
end
