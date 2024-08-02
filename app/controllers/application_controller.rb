require Rails.root.join('app/services/jwt/jwt_wrapper')
class ApplicationController < ActionController::API
  respond_to :json

  private

  def validate_token(token)
    if token && token['sub'].present?
      jti = token['jti']
      if JwtDenylist.exists?(jti:)
        render json: { error: I18n.t('active_record.auth.errors.revoked_jwt') },
               status: :unauthorized
      end
    else
      render json: { error: I18n.t('active_record.auth.errors.invalid_jwt') },
             status: :unauthorized
    end
  end

  def authenticate_user!
    if request.headers['Authorization'].present?
      jwt_payload = decoded_jwt_token
      validate_token(jwt_payload)
    else
      render json: { error: I18n.t('active_record.auth.errors.jwt_not_found_in_header') },
             status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_jwt_token['sub']) if decoded_jwt_token
  end

  def decoded_jwt_token
    token = request.headers['Authorization']&.split&.last
    JWTWrapper.decode(token) if token
  end
end
