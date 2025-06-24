module Jwt
  class JwtWrapper
    def self.decode(token)
      # secret_key = ENV['DEVISE_JWT_SECRET_KEY'] || raise("Missing DEVISE_JWT_SECRET_KEY in environment")
      secret_key = Rails.application.credentials.jwt.secret

      begin
        decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
        decoded_token.first
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
