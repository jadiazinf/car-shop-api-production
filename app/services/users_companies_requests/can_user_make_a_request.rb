class UsersCompaniesRequests::CanUserMakeARequest
  attr_accessor :user_company

  def initialize(params)
    @user_company = UserCompany.includes(:company).find_by(user_id: params[:user_id],
                                                           company_id: params[:company_id])
  end

  def perform
    return false unless user_company.roles.include?('admin')

    last_request = find_last_request
    last_request.status == 'rejected'
  end

  private

  def find_last_request
    UserCompanyRequest
      .joins(user_company: :company)
      .where(companies: { id: user_company.company.id })
      .order(created_at: :desc)
      .first
  end
end
