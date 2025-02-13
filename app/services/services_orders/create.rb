class ServicesOrders::Create
  attr_reader :cost, :service_id, :order_id, :status

  def initialize(params)
    @cost = params[:cost]
    @service_id = params[:service_id]
    @order_id = params[:order_id]
    @status = params[:status]
  end

  def perform
    service_order = ServiceOrder.new(cost:, service_id:, order_id:, status:)
    if service_order.save
      [true, service_order]
    else
      [false, service_order.errors.full_messages]
    end
  end
end
