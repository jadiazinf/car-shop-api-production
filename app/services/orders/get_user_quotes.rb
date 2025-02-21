class Orders::GetUserQuotes
  attr_reader :status, :user_id, :vehicle_id, :is_active, :is_checked

  def initialize(params)
    @status = params.key?(:status) ? params[:status] : nil
    @user_id = params[:user_id]
    @vehicle_id = params.key?(:vehicle_id) ? params[:vehicle_id] : nil
    @is_checked = params.key?(:is_checked) ? params[:is_checked] : nil
    @is_active = params.key?(:is_active) ? params[:is_active] : nil
  end

  def perform # rubocop:disable Metrics/AbcSize
    orders = Order.joins(:vehicle).includes(:service_orders, :vehicle, :company)
      .where(vehicles: { user_id: }).order(:created_at)
    orders = orders.where(status:) unless status.nil?
    orders = orders.where(vehicle_id:) unless vehicle_id.nil?
    orders = orders.where(is_checked:) unless is_checked.nil?
    orders = orders.where(is_active:) unless is_active.nil?
    orders
  end
end
