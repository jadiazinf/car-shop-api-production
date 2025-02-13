class Orders::Create
  attr_reader :vehicle_mileage, :vehicle_id, :services_orders, :company_id, :status, :created_by,
              :is_checked, :is_active

  def initialize(params)
    @vehicle_mileage = params[:vehicle_mileage]
    @vehicle_id = params[:vehicle_id]
    @services_orders = params.key?(:services_orders) ? params[:services_orders] : []
    @company_id = params[:company_id]
    @status = params[:status]
    @created_by = params[:created_by]
    @is_checked = params[:is_checked]
    @is_active = params[:is_active]
  end

  def perform
    order = Order.new(vehicle_mileage:, vehicle_id:, company_id:, status:,
                      created_by_id: created_by, is_checked:, is_active:)
    if order.save
      service_orders_errors = create_services_orders(order.id)
      [true, order, service_orders_errors]
    else
      [false, order.errors.full_messages, nil]
    end
  end

  private

  def create_services_orders(order_id)
    _, errors = ServicesOrders::CreateInBatch.new(services_orders, order_id).perform

    errors
  end
end
