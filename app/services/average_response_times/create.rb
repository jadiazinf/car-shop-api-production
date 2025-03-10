class AverageResponseTimes::Create
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def perform
    return unless order.status == 'quote'

    AverageResponseTime.create(order_id: order.id, company_id: order.company_id,
                               user_id: order.vehicle.user_id)
  end
end
