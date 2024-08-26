class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name,
                                 :last_name, :dni, :birthdate, :address, :phonenumber, :gender)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      configure_header
      render_success_response(resource)
    else
      render_bad_request(resource.errors)
    end
  rescue StandardError
    render_internal_server_error(I18n.t('active_record.errors.standard_error'))
  end

  def configure_header
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token
  end

  def handle_login_request
    Users::AuthService.new(email: params[:user][:email],
                           password: params[:user][:password]).handle_login_request
  end

  def render_response(obj)
    render 'application_response',
           status: :ok,
           locals: { ok: obj[:ok], status: obj[:status], data: obj[:data], message: obj[:message],
                     errors: obj[:errors] }
  end

  def render_unauthorized(errors)
    render_response(ok: false, status: :unauthorized, data: nil, message: nil, errors:)
  end

  def render_success_response(data)
    render_response(ok: true, status: :ok, data:,
                    message: nil, errors: nil)
  end

  def render_internal_server_error(errors)
    render_response(ok: false, status: :internal_server_error, data: nil, message: nil, errors:)
  end

  def render_bad_request(errors)
    render_response(ok: false, status: :bad_request, data: nil, message: nil, errors:)
  end
end
