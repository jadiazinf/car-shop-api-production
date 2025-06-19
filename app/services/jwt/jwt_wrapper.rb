module Jwt
  class JwtWrapper
    def self.decode(token)
      # secret_key = Rails.application.credentials.jwt.secret

      # secret_key = if Rails.application.credentials.SECRET_KEY_BASE || Rails.application.credentials.secret_key_base
      #           Rails.application.credentials.jwt.secret
      #         else
      #           ENV.fetch("SECRET_KEY_BASE")
      #         end

      # secret_key = ENV['JWT_SECRET_KEY']

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
