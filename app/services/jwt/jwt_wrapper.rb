module Jwt
  class JwtWrapper
    def self.decode(token)
      # secret_key = Rails.application.credentials.jwt.secret
      secret_key = ENV.fetch("SECRET_KEY_BASE")

      begin
        decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
        decoded_token.first
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
