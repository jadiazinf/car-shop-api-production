class UsersCompaniesRequests::CanUserMakeARequest
  def initialize(params)
    @company_id = params[:company_id]
    @user_id = params[:user_id]
    @user_company = UserCompany.where(user_id: params[:user_id],
                                      company_id: params[:company_id]).first
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
      .where(companies: { id: @company_id })
      .order(created_at: :desc)
      .first
  end
end
