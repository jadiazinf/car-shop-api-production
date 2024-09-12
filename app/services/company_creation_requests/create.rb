class CompanyCreationRequests::Create
  attr_reader :company_id

  def initialize(params)
    @company_id = params[:company_id]
    validate_params
  end

  def perform
    request = CompanyCreationRequest.new(company_id:)
    request.save
    if request.save
      { success: true, request: }
    else
      { success: false, errors: request.errors.full_messages }
    end
  rescue StandardError => e
    { success: false, error: e.message }
  end

  private

  def validate_params
    return if company_id

    raise ArgumentError,
          I18n.t('active_record.company_creation_requests.errors.company_id_required')
  end
end
