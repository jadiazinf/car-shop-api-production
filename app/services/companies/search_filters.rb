class Companies::SearchFilters
  attr_reader :company_name, :service_name, :categories_ids, :city_id

  def initialize(params)
    @company_name = params[:company_name]
    @service_name = params[:service_name]
    @categories_ids = params[:category_ids]
    @city_id = params[:location_id]
    @companies = Company.where(is_active: true)
    @filters_applied = false
  end

  def perform
    filter_by_name
    filter_by_service
    filter_by_categories
    filter_by_location

    return @companies if @filters_applied

    @companies
  end

  private

  def filter_by_name
    return if company_name.blank?

    @filters_applied = true
    @companies = @companies.where('companies.name ILIKE ?', "%#{company_name}%")
  end

  def filter_by_service
    return if service_name.blank?

    @filters_applied = true
    @companies = @companies.joins(:services).where('services.name ILIKE ?', "%#{service_name}%")
  end

  def filter_by_categories
    return if categories_ids.blank?

    @filters_applied = true
    categories = categories_ids.split(',')
    @companies = @companies.joins(:services).where(services: { category_id: categories })
  end

  def filter_by_location
    return if city_id.blank?

    @filters_applied = true
    city_towns = Locations::LocationChildrens.new(city_id).perform
    @companies = @companies.where(location_id: city_towns.pluck(:id))
  end
end
