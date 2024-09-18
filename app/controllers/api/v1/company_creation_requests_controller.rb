class Api::V1::CompanyCreationRequestsController < ApplicationController
  def index
    company_creation_requests = CompanyCreationRequest.all
    render json: company_creation_requests, status: :ok
  end

  def show
    id = params[:id]
    company_creation_request = CompanyCreationRequest.find(id)
    render json: company_creation_request, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def show_by_company_id
    company_id = params[:company_id]
    company_creation_request = CompanyCreationRequest.find_by(company_id:)
    render json: company_creation_request, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    id = params[:id]
    service = CompanyCreationRequests::Update.new(company_creation_request_params.merge(id:))
    service.perform
    render_success
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_content
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def render_success
    message = I18n.t('active_record.company_creation_requests.success.request_created')
    render json: { message: }, status: :ok
  end

  def company_creation_request_params
    params.require(:company_creation_request).permit(:company_id, :responder_user_id, :status,
                                                     :message)
  end
end
