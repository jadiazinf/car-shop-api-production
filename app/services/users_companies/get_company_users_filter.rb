class UsersCompanies::GetCompanyUsersFilter
  attr_accessor :name, :status, :roles, :company_id, :dni

  def initialize(params)
    @name = params[:name].to_s.strip
    @status = params[:status].to_s.strip
    @roles = params[:roles].to_s.strip
    @dni = params[:dni].to_s.strip
    @company_id = params[:company_id]
  end

  def perform
    user_company = base_scope

    user_company = filter_by_name(user_company) unless name.empty?
    user_company = filter_by_dni(user_company) unless dni.empty?
    user_company = filter_by_roles(user_company) unless roles.empty?
    user_company = filter_by_is_active(user_company) unless status.empty?

    user_company
  end

  private

  def base_scope
    UserCompany.includes(:user).where(company_id:, is_active: true)
  end

  def filter_by_name(user_company)
    user_company.joins(:user)
      .where('unaccent(LOWER(users.first_name)) LIKE unaccent(?) OR ' +
      'unaccent(LOWER(users.last_name)) LIKE unaccent(?)',
      "%#{name.downcase}%", "%#{name.downcase}%")
  end

  def filter_by_dni(user_company)
    user_company.joins(:user).where('LOWER(users.dni) LIKE ?', "%#{dni.downcase}%")
  end

  def filter_by_roles(user_company)
    user_roles = roles.split(',')
    user_company.joins(:user).where('roles && ARRAY[?]::varchar[]', user_roles)
  end

  def filter_by_is_active(user_company)
    active = ActiveRecord::Type::Boolean.new.cast(status)
    user_company.where(is_active: active)
  end
end
