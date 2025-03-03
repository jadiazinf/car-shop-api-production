class Api::V1::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user

  def orders_with_claims
    UsersActivitiesLogs::Create.new(current_user, 'list orders with claims report').perform
    orders_with_claims = Order
      .joins(:user_order_review)
      .where(company_id: params[:company_id], user_order_reviews: { rating: ...3 })
      .where(created_at: params[:start_date]..params[:end_date])
      .count

    render json: { orders_with_claims: orders_with_claims.as_json }, status: :ok
  end

  def orders_without_claims
    UsersActivitiesLogs::Create.new(current_user, 'list orders without claims report').perform
    orders_without_claims = Order.left_joins(:user_order_review)
      .where(company_id: params[:company_id], status: %i[finished canceled])
      .where('user_order_reviews.rating IS NULL OR user_order_reviews.rating >= 3')
      .where(created_at: params[:start_date]..params[:end_date])
      .count

    render json: { orders_without_claims: orders_without_claims.as_json }, status: :ok
  end

  def claims_by_service_category
    UsersActivitiesLogs::Create.new(current_user, 'list orders with claims report').perform
    claims_by_service_category = UserOrderReview
      .joins(order: { services: :category })
      .where(order: { company_id: params[:company_id] })
      .where(rating: ...3, created_at: params[:start_date]..params[:end_date])
      .group('categories.name')
      .count

    render json: { claims_by_service_category: claims_by_service_category.as_json }, status: :ok
  end

  def claims_by_period
    UsersActivitiesLogs::Create.new(current_user, 'List claims by period report').perform
    claims_by_period = UserOrderReview
      .joins(:order)
      .where(order: { company_id: params[:company_id] })
      .where(rating: ...3, created_at: params[:start_date]..params[:end_date])
      .group_by_month(:created_at)
      .count

    render json: { claims_by_period: claims_by_period.as_json }, status: :ok
  end

  def customers_served_by_period
    UsersActivitiesLogs::Create.new(current_user, 'list customers served by period report').perform
    customers_served_by_period = Order
      .where(company_id: params[:company_id])
      .where(created_at: params[:start_date]..params[:end_date])
      .group_by_month(:created_at)
      .distinct.count(:vehicle_id)

    render json: { customers_served_by_period: customers_served_by_period.as_json }, status: :ok
  end

  def captured_customers_percentage_by_period # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    UsersActivitiesLogs::Create.new(current_user,
                                    'list catpured customers percentage report').perform
    total_orders = Order
      .where(company_id: params[:company_id],
             created_at: params[:start_date]..params[:end_date])
      .distinct.count(:vehicle_id)

    captured_orders = Order
      .where(company_id: params[:company_id],
             status: %w[in_progress finished
                        canceled],
             created_at: params[:start_date]..params[:end_date])
      .distinct.count(:vehicle_id)

    captured_customers_percentage = if total_orders.zero?
                                      0
                                    else
                                      (captured_orders.to_f / total_orders * 100).round(2)
                                    end

    render json: { captured_customers_percentage_by_period: { total_orders:,
                                                              captured_customers_percentage:,
                                                              captured_orders: } }, status: :ok
  end

  def captured_customers_by_service_category_and_period # rubocop:disable Metrics/AbcSize
    UsersActivitiesLogs::Create.new(current_user, 'list captured customers report').perform
    captured_customers_by_service_category_and_period = Service
      .joins(:service_orders)
      .joins(service_orders: :order)
      .joins(:category)
      .where(
        company_id: params[:company_id],
        orders: { status: %w[quote active_for_order_creation] },
        created_at: params[:start_date]..params[:end_date]
      )
      .group('categories.name')
      .distinct.count(:vehicle_id)

    render json: { captured_customers_by_service_category_and_period: },
           status: :ok
  end

  private

  def reports_params
    params.require(:report).permit(:start_date, :end_date, :company_id, :order_status)
  end

  def validate_user
    user_company = UserCompany.find_by(user_id: current_user.id,
                                       company_id: params[:company_id].to_i)

    return if user_company.roles.include?('admin')

    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
