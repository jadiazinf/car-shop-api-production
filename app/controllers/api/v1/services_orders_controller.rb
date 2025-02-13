class Api::V1::ServicesOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order, only: %i[show update]

  def index; end

  def show
    company = Company.find(params[:company_id])
    if @service_order.belongs_to_user?(current_user) || @service_order.belongs_to_company?(company)
      render :show, status: :ok
    else
      render json: { errors: ['Service order not found'] }, status: :not_found
    end
  end

  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      render :show, status: :created
    else
      render json: { errors: @service_order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @service_order.update(service_order_params)
    render :show, status: :ok
  end

  def create_in_batch
    is_valid, errors = ServicesOrders::CreateInBatch.new(params[:services_orders],
                                                         params[:order_id]).perform

    if is_valid
      render json: { message: 'Service orders created successfully', errors: }, status: :created
    else
      render json: { errors: }, status: :unprocessable_entity
    end
  end

  def update_services_orders_status
    services_orders = ServicesOrders::UpdateServicesOrdersStatus.new(
      service_order_params[:order_id], service_order_params[:status]
    ).perform
    render json: { message: 'Service orders status updated successfully', services_orders: },
           status: :ok
  end

  def orders_by_assigned_to
    service_orders = ServiceOrder.includes(:service,
                                           order: [:vehicle])
      .where(assigned_to: params[:assigned_to])
      .page(params[:page])

    render json: service_orders.as_json(include: [:service, { order: { vehicle: } }]), status: :ok
  end

  private

  def service_order_params
    params.require(:service_order).permit(:id, :cost, :status, :service_id, :order_id, :assigned_to)
  end

  def set_service_order
    @service_order = ServiceOrder.includes(:service, order: [:vehicle]).find(params[:id])
  end
end
