class Api::V1::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, unless: :devise_controller?
  respond_to :json

  protected

  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      status: {
        code: 200, message: I18n.t('active_record.auth.success.sign_in_success'),
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_token = request.headers['Authorization']&.split&.last
    result = Jwt::Logout.new(jwt_token:).handle
    if result.first == true
      render json: { message: result.last }, status: :ok
    else
      render json: { error: result.last }, status: :bad_request
    end
  end
end
