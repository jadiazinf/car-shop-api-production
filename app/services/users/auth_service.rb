class Users::AuthService
  attr_accessor :email, :password

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def compare_passwords(user)
    user.valid_password?(@password)
  end

  def handle_login_request
    user = User.find_by(email: @email)
    return [false, I18n.t('active_record.auth.errors.invalid_email')] unless user

    unless compare_passwords(user)
      return [false, I18n.t('active_record.auth.errors.invalid_password')]
    end

    [true, user]
  end
end
