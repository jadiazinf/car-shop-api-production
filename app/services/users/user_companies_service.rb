class Users::UserCompaniesService
  attr_accessor :name, :rif, :status, :user_id

  def initialize(params)
    @name = params[:name].to_s.strip
    @rif = params[:rif].to_s.strip
    @status = params[:status].to_s.strip
    @user_id = params[:user_id]
  end

  def perform
    companies = base_scope

    companies = filter_by_name(companies) unless name.empty?
    companies = filter_by_rif(companies) unless rif.empty?
    companies = filter_by_is_active(companies) unless status.empty?

    companies
  end

  private

  def base_scope
    Company.joins(:user_companies).where(user_companies: { user_id:, is_active: true })
  end

  def filter_by_name(companies)
    companies.where('LOWER(name) LIKE ?', "%#{name.downcase}%")
  end

  def filter_by_rif(companies)
    companies.where('LOWER(dni) LIKE ?', "%#{rif.downcase}%")
  end

  def filter_by_is_active(companies)
    active = ActiveRecord::Type::Boolean.new.cast(status)
    companies.where(is_active: active)
  end
end
