class Api::V1::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, unless: :devise_controller?
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    UsersActivitiesLogs::Create.new(current_user, 'Create user session').perform
    respond_with resource
  end

  protected

  def respond_with(_resource, _opts = {})
    auth_result = Users::AuthService.new(email: params[:user][:email],
                                         password: params[:user][:password]).handle_login_request
    if auth_result.first == false
      render_unauthorized(auth_result[1])
    else
      configure_header
      render_success_response({ user: auth_result[1] })
    end
  rescue StandardError
    render_internal_server_error(I18n.t('active_record.errors.standard_error'))
  end

  def respond_to_on_destroy
    jwt_token = request.headers['Authorization']&.split&.last
    result = Jwt::Logout.new(jwt_token:).handle
    if result.first == true
      render_success_response(result.last)
    else
      render_internal_server_error(result.last)
    end
  end

  private

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
           status: obj[:status],
           locals: { ok: obj[:ok], status: obj[:status], data: obj[:data], message: obj[:message],
                     errors: obj[:errors] }
  end

  def render_unauthorized(errors)
    render_response(ok: false, status: :unauthorized, data: nil, message: nil, errors:)
  end

  def render_success_response(data)
    render_response(ok: true, status: :ok, data:,
                    message: I18n.t('active_record.auth.success.sign_in_success'), errors: nil)
  end

  def render_internal_server_error(errors)
    render_response(ok: false, status: :internal_server_error, data: nil, message: nil, errors:)
  end
end
