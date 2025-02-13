class Orders::GetUserOrders
  attr_reader :status, :user_id, :vehicle_id, :is_checked, :is_active

  def initialize(params)
    @status = params.key?(:status) ? params[:status] : nil
    @user_id = params[:user_id]
    @vehicle_id = params.key?(:vehicle_id) ? params[:vehicle_id] : nil
    @is_checked = params.key?(:is_checked) ? params[:is_checked] : nil
    @is_active = params.key?(:is_active) ? params[:is_active] : nil
  end

  def perform
    orders = by_status
    orders = orders.where(vehicle_id:) unless vehicle_id.nil?
    orders = orders.where(is_checked:) unless is_checked.nil?
    orders = orders.where(is_active:) unless is_active.nil?

    orders
  end

  private

  def by_status
    if status.nil? || status == 'quote'
      Order.joins(:vehicle).where.not(status: 'quote').where(vehicle: { user_id: })
        .order(:created_at)
    else
      Order.joins(:vehicle).where(status:, vehicle: { user_id: }).order(:created_at)
    end
  end
end
