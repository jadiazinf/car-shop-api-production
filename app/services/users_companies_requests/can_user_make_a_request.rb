class UsersCompaniesRequests::CanUserMakeARequest
  def initialize(params)
    @user_company = UserCompany.includes(:company).find(params[:user_company_id])
    @user_id = params[:user_id]
  end

  def perform
    return false unless @user_company.roles.include?('admin')

    last_request = find_last_request
    last_request.status == 'rejected'
  end

  private

  def find_last_request
    UserCompanyRequest
      .joins(user_company: :company)
      .where(companies: { id: @user_company.company.id })
      .order(created_at: :desc)
      .first
  end
end
