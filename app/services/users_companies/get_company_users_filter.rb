class UsersCompanies::GetCompanyUsersFilter
  attr_accessor :name, :company_id, :page

  def initialize(params)
    @name = params[:name]
    @company_id = params[:company_id]
    @page = params[:page]
  end

  def perform
    user_companies = if name.present?
                       filter_users
                     else
                       fetch_user_companies
                     end

    Kaminari.paginate_array(transform_data(user_companies), total_count: user_companies.total_count)
      .page(user_companies.current_page)
      .per(user_companies.limit_value)
  end

  private

  def fetch_user_companies
    UserCompany.includes(:user)
      .where(company_id:, is_active: true)
      .page(page)
  end

  def filter_users
    query_string = "unaccent(users.first_name || ' ' || users.last_name) ILIKE unaccent(?)"
    UserCompany.joins(:user)
      .where(company_id:, is_active: true)
      .where(query_string, "%#{name}%")
      .includes(:user)
      .page(page)
  end

  def transform_data(users)
    users.map do |user_company|
      {
        id: user_company.id,
        roles: user_company.roles,
        is_active: user_company.is_active,
        user_id: user_company.user_id,
        company_id: user_company.company_id,
        user: user_company.user&.attributes&.symbolize_keys
      }
    end
  end
end
