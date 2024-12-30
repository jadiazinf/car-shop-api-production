class UsersCompanies::ValidateUserCompany
  attr_reader :email, :dni, :company_id

  def initialize(params)
    @email = params[:email]
    @dni = [:dni]
    @company_id = params[:company_id]
  end

  def perform
    return valid_with_email? if email.present?

    return valid_with_dni? if dni.present?

    { user_is_registered: false }
  end

  private

  def valid_with_email?
    user = User.find_by(email:)
    user_company = UserCompany.find_by(user_id: user.id, company_id:)
    return user_company.attributes.merge(user:) if user_company.present?

    user_company
  end

  def valid_with_dni?
    user = User.find_by(dni:)
    return false if user.nil?

    user_company = UserCompany.find_by(user_id: user.id, company_id:)
    return user_company.attributes.merge(user:) if user_company.present?

    user_company
  end
end
