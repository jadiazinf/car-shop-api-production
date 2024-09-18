class Companies::Create
  def initialize(params)
    @params = params
  end

  def perform
    create_company
    save_company_charter unless @company.errors.any?
    save_company_images unless @company.errors.any?
    create_request_for_company_creation unless @company.errors.any?
    { ok: @company.errors.empty?, data: @company, errors: @company.errors }
  end

  private

  def create_company
    @company = Company.new(@params)
    return unless @company.valid?

    validate_user
    return unless @company.errors.empty?

    relate_user_with_company
    @company.save
  end

  def relate_user_with_company
    @user.company_id = @company.id
    @user.save
  end

  def validate_user
    if @params[:users].blank?
      @company.errors.add(:users, I18n.t('active_record.companies.errors.user_is_required'))
      return
    end
    @user = User.find(@params[:users][0].id)
    return unless @user.nil?

    @company.errors.add(:users, I18n.t('active_record.users.errors.user_not_found'))
  end

  def save_company_charter
    @company.company_charter.attach(@params[:company_charter])
    @company.save
  end

  def save_company_images
    @params[:company_images].each do |image|
      @company.company_images.attach(image)
    end
  end

  def create_request_for_company_creation
    company_creation_request = CompanyCreationRequests::Create.new(company_id: @company.id)
    company_creation_request.perform
  end
end
