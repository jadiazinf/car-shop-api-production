class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name,
                                 :last_name, :dni, :birthdate, :address, :phonenumber)
  end

  def respond_with(resource, _opts = {}) # rubocop:disable Metrics/MethodLength
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token
      render json: {
        status: {
          code: 200,
          message: I18n.t('active_record.auth.success.sign_up_success'),
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: {
        status: { message: @user.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
end
