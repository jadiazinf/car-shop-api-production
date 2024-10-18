class Api::V1::UsersCompaniesRequestsController < ApplicationController
  def index
    @requests = if params[:status].present?
                  UserCompanyRequest.where(status: params[:status]).page(params[:page].to_i)
                else
                  UserCompanyRequest.page(params[:page].to_i)
                end
  end

  def show
    company_creation_request = UserCompanyRequest.find(params[:id])
    render json: company_creation_request, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def show_by_company_id
    @company_creation_request = if params[:status].present?
                                  company_creation_requests_by_status
                                else
                                  all_company_creation_requests
                                end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    id = params[:id]
    service = UserCompanyRequest::Update.new(company_creation_request_params.merge(id:))
    service.perform
    render_success
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_content
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  def can_user_make_a_request
    service = UserCompanyRequest::CanUserMakeARequest.new({ user_id: params[:user_id] })
    result = service.perform
    render json: { can_make_request: result }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  private

  def render_success
    message = I18n.t('active_record.users_companies_requests.success.request_created')
    render json: { message: }, status: :ok
  end

  def company_creation_request_params
    params.require(:company_creation_request).permit(:company_id, :responder_user_id, :status,
                                                     :message, :page, :status)
  end

  def all_company_creation_requests
    UserCompanyRequest.where(company_id: params[:id])
      .order(created_at: :desc)
      .page(params[:page].to_i)
  end

  def company_creation_requests_by_status
    UserCompanyRequest.where(company_id: params[:id], status: params[:status])
      .order(created_at: :desc)
      .page(params[:page].to_i)
  end
end
