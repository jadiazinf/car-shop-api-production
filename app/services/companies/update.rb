class Companies::Update
  def initialize(params)
    @params = params
    @user = params[:user]
    @company = params[:company]
  end

  def perform
    update_company_charter if @params[:company_charter].present?
    save_company_images if @params[:company_images].present?
    update_company
    create_request_for_company_creation
    { ok: @company.errors.empty?, data: @company, errors: @company.errors }
  end

  private

  def update_company
    @company.update(@params.except(:user, :company))
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
    user_company = UserCompany.find_by(company_id: @company.id, user_id: @user.id)
    return unless user_company

    company_creation_request = UsersCompaniesRequests::Create.new(user_company_id: user_company.id)
    company_creation_request.perform
  end
end
