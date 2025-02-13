class ServicesOrders::GetServicesOrdersByOrderId
  attr_reader :order_id, :status

  def initialize(order_id, status)
    @order_id = order_id
    @status = status || nil
  end

  def perform
    services_orders = ServicesOrders.where(order_id:).order(:created_at)
    services_orders = services_orders.where(status:) unless status.nil?

    services_orders
  end
end
