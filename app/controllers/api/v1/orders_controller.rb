class Api::V1::OrdersController < ApplicationController # rubocop:disable Metrics/ClassLength
  before_action :authenticate_user!
  before_action :set_company,
                except: %i[user_orders user_quotes create]
  before_action :set_order, only: %i[show update add_user_company]
  before_action :set_user_company,
                only: %i[company_orders company_quotes add_user_company by_assigned_to]
  before_action :validate_user_company, only: %i[company_orders company_quotes by_assigned_to]
  before_action :validate_order,
                only: %i[show update add_user_company add_user_company]

  def index
    UsersActivitiesLogs::Create.new(current_user, 'list orders').perform
    @orders = @company.orders.where(is_active: true).page(params[:page])
  end

  def show
    UsersActivitiesLogs::Create.new(current_user, 'Show an order info').perform
    if @order.belongs_to_user?(current_user) || @order.belongs_to_company?(@company)
      render :show, status: :ok
    else
      render json: { errors: ['Order not found'] }, status: :not_found
    end
  end

  def create
    UsersActivitiesLogs::Create.new(current_user, 'Create order').perform
    service = Orders::Create.new(order_params)
    is_valid, data, services_orders_errors = service.perform
    if is_valid
      render json: { order: data, services_orders_errors: }, status: :created
    else
      render json: { errors: data }, status: :unprocessable_entity
    end
  end

  def update
    UsersActivitiesLogs::Create.new(current_user, 'Update order').perform
    if @order.belongs_to_company?(@company)
      AverageResponseTimes::Create.new(@order).perform
      @order.update(order_params)
      render :show, status: :ok
    else
      render json: { errors: ['Order not found'] }, status: :not_found
    end
  end

  def company_orders
    UsersActivitiesLogs::Create.new(current_user, 'List company orders for company member').perform
    if @user_company.company_id == @company.id && @user_company.is_active
      response = Orders::GetCompanyOrders.new(params).perform
      @orders = response.page(params[:page])
      render :index, status: :ok
    else
      render json: { errors: ['Orders not found'] }, status: :not_found
    end
  end

  def company_quotes
    UsersActivitiesLogs::Create.new(current_user, 'List company quotes for company member').perform
    if (@user_company.company_id == @company.id) && @user_company.is_active
      response = Orders::GetCompanyQuotes.new(params).perform
      @orders = response.page(params[:page])
      render :index, status: :ok
    else
      render json: { errors: ['Quotes not found'] }, status: :not_found
    end
  end

  def user_orders
    UsersActivitiesLogs::Create.new(current_user, 'list orders for user').perform
    response = Orders::GetUserOrders.new(params.except(:user_id).merge(user_id: current_user.id))
      .perform
    @orders = response.page(params[:page])
    render :index, status: :ok
  end

  def user_quotes
    UsersActivitiesLogs::Create.new(current_user, 'list quotes for user').perform
    response = Orders::GetUserQuotes.new(params.except(:user_id).merge(user_id: current_user.id))
      .perform
    @orders = response.page(params[:page])
    render :index, status: :ok
  end

  def add_user_company
    is_valid, message, service_order = Orders::AddUserCompany.new(
      @order.id, order_params[:user_company_id]
    ).perform

    if is_valid
      render json: { service_order: }, status: :ok
    else
      render json: { errors: [message] }, status: :unprocessable_entity
    end
  end

  def by_assigned_to
    UsersActivitiesLogs::Create.new(current_user, 'list technician orders').perform
    response = Orders::OrdersByAssignedTo.new(params).perform
    @orders = response.page(params[:page])
    render :index, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:id, :status, :vehicle_mileage, :is_active, :vehicle_id,
                                  :company_id, :is_checked, :created_by, :assigned_to,
                                  :user_company_id,
                                  services_orders: %i[cost status service_id order_id id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_user_company
    @user_company = UserCompany.find_by(user_id: current_user.id, company_id: params[:company_id])
  end

  def set_order
    @order = Order.includes(assigned_to: [:user]).find_by(id: params[:id])
  end

  def validate_order
    return if @order.belongs_to_company?(@company)

    render json: { errors: ['Order not found'] }, status: :not_found
  end

  def validate_user_company
    return if @user_company.company_id == @company.id && @user_company.is_active

    render json: { errors: ['User company not found'] }, status: :not_found
  end

  def validate_admin_or_assigned_by
    return if current_user.admin? || @order.assigned_to_id == current_user.id

    render json: { errors: ['You are not allowed to perform this action'] }, status: :forbidden
  end
end
