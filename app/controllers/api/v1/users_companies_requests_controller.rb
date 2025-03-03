class Api::V1::UsersCompaniesRequestsController < ApplicationController
  def index # rubocop:disable Metrics/AbcSize
    @requests = if params[:status].present?
                  UserCompanyRequest
                    .includes(user_company: %i[user company])
                    .where(status: params[:status])
                    .order(created_at: :desc)
                    .page(params[:page].to_i)
                else
                  UserCompanyRequest
                    .includes(user_company: %i[user company])
                    .order(created_at: :desc)
                    .page(params[:page].to_i)
                end
  end

  def show
    UsersActivitiesLogs::Create.new(current_user, 'Show a company request for registration').perform
    @request = UserCompanyRequest.includes(user_company: { user: [], company: [:location] })
      .find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def show_by_company_id
    UsersActivitiesLogs::Create.new(current_user, 'Show registration requests to a company').perform
    @requests = if params[:status].present?
                  company_requests_by_status
                else
                  all_company_requests
                end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update # rubocop:disable Metrics/AbcSize
    UsersActivitiesLogs::Create.new(current_user, 'Update company registration request').perform
    id = params[:id]
    service = UsersCompaniesRequests::Update.new(company_creation_request_params.merge(id:))
    service.perform
    render_success
  rescue ActiveRecord::RecordNotFound => e
    render json: [error: e.message], status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: [e.message.full_messages], status: :unprocessable_content
  rescue ArgumentError => e
    render json: [e.message], status: :bad_request
  end

  def can_user_make_a_request
    service = UsersCompaniesRequests::CanUserMakeARequest.new({ user_id: params[:user_id],
                                                                company_id: params[:company_id] })
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
    params.require(:user_company_request).permit(:user_company_id, :responder_user_id, :status,
                                                 :message, :page, :status)
  end

  def all_company_requests
    UserCompanyRequest
      .includes(user_company: %i[user company])
      .where(company_id: params[:id])
      .order(created_at: :desc)
      .page(params[:page].to_i)
  end

  def company_requests_by_status
    UserCompanyRequest
      .includes(user_company: %i[user company])
      .where(user_company: { company_id: params[:id] }, status: params[:status])
      .order(created_at: :desc)
      .page(params[:page].to_i)
  end
end
