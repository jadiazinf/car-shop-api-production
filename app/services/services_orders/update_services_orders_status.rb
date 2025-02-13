class ServicesOrders::UpdateServicesOrdersStatus
  attr_reader :order_id, :status

  def initialize(order_id, status)
    @order_id = order_id
    @status = status
  end

  def perform
    services_orders = ServiceOrder.where(order_id:)
    services_orders.each do |service_order|
      service_order.update(status:)
    end

    services_orders
  end
end
