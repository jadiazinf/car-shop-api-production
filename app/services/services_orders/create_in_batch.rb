class ServicesOrders::CreateInBatch
  attr_reader :data, :order_id

  def initialize(params, order_id)
    @data = params
    @order_id = order_id
  end

  def perform
    errors = []

    data.each do |service_order|
      is_valid, result = ServicesOrders::Create.new(service_order.merge(order_id:)).perform
      errors << result unless is_valid
    end

    [data.length > errors.length, errors]
  end
end
