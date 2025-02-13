class Orders::OrdersByAssignedTo
  attr_reader :assigned_to, :status, :is_checked, :is_active, :license_plate

  def initialize(params)
    @assigned_to = params[:assigned_to]
    @status = params.key?(:status) ? params[:status] : nil
    @is_checked = params.key?(:is_checked) ? params[:is_checked] : nil
    @is_active = params.key?(:is_active) ? params[:is_active] : nil
    @license_plate = params.key?(:license_plate) ? params[:license_plate] : nil
  end

  def perform # rubocop:disable Metrics/AbcSize
    orders = Order.includes(:vehicle, :services).where(assigned_to_id: assigned_to)
    orders = filter_by_status(orders) if status
    orders = orders.where(is_checked:) unless is_checked.nil?
    orders = orders.where(is_active:) unless is_active.nil?
    unless license_plate.nil?
      orders = orders.where('vehicles.license_plate ILIKE ?', "%#{license_plate}%")
    end

    orders
  end

  private

  def filter_by_status(orders)
    orders.where(status:)
  end
end
