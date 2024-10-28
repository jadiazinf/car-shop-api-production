class UsersCompaniesRequests::Update
  attr_reader :request, :responder_user_id, :status, :message

  def initialize(params)
    @request = UserCompanyRequest.find(params[:id])
    @responder_user_id = params[:responder_user_id]
    @status = params[:status]
    @message = params[:message]
  end

  def perform
    update_request
    activate_company if request_approved?
  end

  private

  def update_request
    request.update!(status:, responder_user_id:, message:)
  end

  def request_approved?
    request.status == 'approved'
  end

  def activate_company
    request.company.update!(is_active: true)
  end
end
