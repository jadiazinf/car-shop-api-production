class Companies::Create
  def initialize(params)
    @params = params
    @user = nil
    @company = nil
  end

  def perform
    validate_user
    return handle_errors if @company&.errors&.any?

    create_company
    return handle_errors if @company.errors.any?

    process_company_files
    request = add_creation_request_for_company unless @company.errors.any?

    build_response(request)
  end

  private

  def handle_errors
    { ok: false, errors: @company.errors }
  end

  def validate_user
    if @params[:user].blank?
      @company = Company.new
      @company.errors.add(:users, I18n.t('active_record.companies.errors.user_is_required'))
      return
    end

    @user = @params[:user]
  end

  def create_company
    @company = Company.new(@params.except(:user))

    return unless @company.valid?

    UserCompany.create(user: @user, company: @company, roles: ['admin'])
    @company.save
  end

  def process_company_files
    save_company_charter
    save_company_images
  end

  def save_company_charter
    return if @params[:company_charter].blank?

    @company.company_charter.attach(@params[:company_charter])
    @company.save
  end

  def save_company_images
    return if @params[:company_images].blank?

    @params[:company_images].each do |image|
      @company.company_images.attach(image)
    end
    @company.save
  end

  def add_creation_request_for_company
    user_company = UserCompany.find_by(company_id: @company.id, user_id: @user.id)
    return unless user_company

    company_creation_request = UsersCompaniesRequests::Create.new(user_company_id: user_company.id)
    company_creation_request.perform
  end

  def build_response(request)
    { ok: @company.errors.empty? && request&.dig(:success), data: @company,
      errors: @company.errors || request&.dig(:errors) }
  end
end
