class Jwt::Logout
  attr_accessor :jwt_token, :jwt_payload

  def initialize(params)
    @jwt_token = params[:jwt_token]
    @jwt_payload = Jwt::JWTWrapper.decode(jwt_token)
  end

  def handle
    return [false, I18n.t('active_record.auth.errors.jwt_not_found_in_header')] if jwt_token.blank?
    if jwt_payload.blank? || jwt_payload['jti'].blank?
      return [false, I18n.t('active_record.auth.errors.invalid_jwt')]
    end
    return [false, I18n.t('active_record.auth.errors.revoked_jwt')] if check_deny_list
    return [true, I18n.t('active_record.auth.success.revoked_jwt')] if create_deny_list

    [false, I18n.t('active_record.auth.errors.revoked_jwt')]
  end

  private

  def check_deny_list
    JwtDenylist.exists?(jti: jwt_payload['jti'])
  end

  def create_deny_list
    exp_value = jwt_payload['exp']
    if JwtDenylist.create(jti: jwt_payload['jti'],
                          exp: Time.zone.at(exp_value).strftime('%Y-%m-%d %H:%M:%S'))
      true
    else
      false
    end
  end
end
