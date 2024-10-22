class UsersCompaniesRequests::Create
  def initialize(params)
    @user_company_id = params[:user_company_id]
  end

  def perform
    request = UserCompanyRequest.new(user_company_id: @user_company_id)
    if request.save
      { success: true, request: }
    else
      { success: false, errors: request.errors.full_messages }
    end
  rescue StandardError => e
    { success: false, error: e.message }
  end
end
