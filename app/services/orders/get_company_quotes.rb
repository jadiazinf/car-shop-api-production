class Orders::GetCompanyQuotes
  attr_reader :status, :company_id, :is_checked, :is_active, :license_plate

  def initialize(params)
    @status = params.key?(:status) ? params[:status] : nil
    @company_id = params[:company_id]
    @is_checked = params.key?(:is_checked) ? params[:is_checked] : nil
    @is_active = params.key?(:is_active) ? params[:is_active] : nil
    @license_plate = params.key?(:license_plate) ? params[:license_plate] : nil
  end

  def perform # rubocop:disable Metrics/AbcSize
    orders = Order.where(company_id:).order(:created_at)

    unless license_plate.nil?
      orders = orders.joins(:vehicle).where('vehicles.license_plate ILIKE ?', "%#{license_plate}%")
    end

    orders = orders.where(status:) unless status.nil?
    orders = orders.where(is_checked:) unless is_checked.nil?
    orders = orders.where(is_active:) unless is_active.nil?

    orders
  end
end
