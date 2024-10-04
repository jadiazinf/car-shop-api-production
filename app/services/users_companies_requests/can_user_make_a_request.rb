class UsersCompaniesRequests::CanUserMakeARequest
  def initialize(params)
    @user = User.find(params[:user_id])
    @company = Company.find(@user.company_id)
  end

  def perform
    return false unless @user.roles.include?('admin')

    last_request = find_last_request
    last_request.status == 'rejected'
  end

  private

  def find_last_request
    UserCompanyRequest.where(company_id: @company.id)
      .order(created_at: :desc)
      .first
  end
end
