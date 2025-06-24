class UsersCompaniesRequests::GetAll
  attr_accessor :name, :rif, :status

  def initialize(params)
    @name = params[:name].to_s.strip
    @rif = params[:rif].to_s.strip
    @status = params[:status].to_s.strip
  end

  def perform
    requests = base_scope

    requests = filter_by_name(requests) unless name.empty?
    requests = filter_by_rif(requests) unless rif.empty?
    requests = filter_by_status(requests) unless status.empty?

    requests
  end

  private

  def base_scope
    UserCompanyRequest.includes(user_company: %i[user company]).order(created_at: :desc)
  end

  def filter_by_name(requests)
    search_term = "%#{name.downcase}%"
    requests.joins(user_company: :company)
            .where("unaccent(LOWER(companies.name)) LIKE unaccent(LOWER(:search))", search: search_term)
  end

  def filter_by_rif(requests)
    requests.joins(user_company: :company)
        .where('LOWER(companies.dni) LIKE ?', "%#{rif.downcase}%")
  end

  def filter_by_status(requests)
    requests.joins(:user_company).where(status:)
  end
end
