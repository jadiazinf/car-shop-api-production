class Api::V1::CompanyCreationRequestsController < ApplicationController
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
