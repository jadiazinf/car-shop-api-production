module Jwt
  class JwtWrapper
    def self.decode(token)
      secret_key = ENV.fetch('DEVISE_JWT_SECRET_KEY')

      begin
        decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
        decoded_token.first
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
