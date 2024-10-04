class Companies::Update
  def initialize(params)
    @params = params
  end

  def perform
    unless validate_company_id
      return { ok: false, data: nil,
               errors: [I18n.t('active_record.errors.general.id_is_required')] }
    end

    update_company_charter if @params[:company_charter].present?
    save_company_images if @params[:company_images].present?
    update_company
    create_request_for_company_creation
    { ok: @company.errors.empty?, data: @company, errors: @company.errors }
  end

  private

  def validate_company_id
    return false if @params[:id].blank? || @params[:id].nil?

    @company = Company.find(@params[:id])
    true
  end

  def update_company
    @company.update(@params.except(:users))
  end

  def purge_old_charter
    @company.company_charter.purge if @company.company_charter.attached?
  end

  def attach_new_charter
    @company.company_charter.attach(@params[:company_charter])
  end

  def update_company_charter
    purge_old_charter
    attach_new_charter
  end

  def purge_old_images
    @company.company_images.purge if @company.company_images.attached?
  end

  def save_company_images
    purge_old_images
    @params[:company_images].each do |image|
      @company.company_images.attach(image)
    end
  end

  def create_request_for_company_creation
    company_creation_request = UsersCompaniesRequests::Create.new(company_id: @company.id)
    company_creation_request.perform
  end
end
