class CompanyCreationRequests::Update
  attr_reader :id, :company_id, :responder_user_id, :status, :message

  def initialize(params)
    @id = params[:id]
    @company_id = params[:company_id]
    @responder_user_id = params[:responder_user_id]
    @status = params[:status]
    @message = params[:message]
    validate_params
  end

  def perform
    ActiveRecord::Base.transaction do
      update_request
      activate_company if request_approved?
    end
  end

  private

  def validate_params
    id_valid?
    company_id_valid?
    responder_user_id_valid?
    status_valid?
    message_valid?
  end

  def id_valid?
    return true if id

    raise ArgumentError, I18n.t('active_record.errors.general.id_is_required')
  end

  def company_id_valid?
    return true if company_id

    raise ArgumentError,
          I18n.t('active_record.company_creation_requests.errors.company_id_required')
  end

  def responder_user_id_valid?
    return true if responder_user_id

    raise ArgumentError,
          I18n.t('active_record.company_creation_requests.errors.responder_id_required')
  end

  def status_valid?
    return true if status

    raise ArgumentError, I18n.t('active_record.company_creation_requests.errors.status_required')
  end

  def message_valid?
    return true if message

    raise ArgumentError, I18n.t('active_record.company_creation_requests.errors.message_required')
  end

  def update_request
    @request = CompanyCreationRequest.find(id)
    @request.update!(status:, responder_user_id:, message:)
  end

  def request_approved?
    @request.status == 'approved'
  end

  def activate_company
    company = Company.find(company_id)
    company.update!(is_active: true)
    company
  end

  def handle_not_found(error)
    message = I18n.t('active_record.company_creation_requests.errors.record_not_found')
    Rails.logger.error("#{message}: #{error.message}")
    raise ActiveRecord::RecordNotFound, error.message
  end

  def handle_validation_error(error)
    message = I18n.t('active_record.company_creation_requests.errors.validation_error')
    Rails.logger.error("#{message}: #{error.message}")
    raise ActiveRecord::RecordInvalid, error.message
  end
end
