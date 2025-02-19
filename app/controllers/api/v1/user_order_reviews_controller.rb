class Api::V1::UserOrderReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index company_ratings]
  before_action :set_user_order_review, only: %i[show]

  def index
    @user_order_reviews = UserOrderReview.includes(order: %i[company vehicle
                                                             assigned_to]).all.page(params[:page])
  end

  def show; end

  def create
    @user_order_review = UserOrderReview.new(user_order_review_params)

    if @user_order_review.save
      render :show, status: :created
    else
      render :show, status: :unprocessable_entity
    end
  end

  def company_reviews
    @user_order_reviews = UserOrderReview
      .includes(order: [:assigned_to])
      .joins(order: %i[company vehicle assigned_to: [user]])
      .where(companies: { id: params[:company_id] })
      .order(created_at: :desc)
      .page(params[:page])

    render :index, status: :ok
  end

  def user_reviews
    @user_order_reviews = UserOrderReview
      .includes(order: [:assigned_to])
      .joins(order: :vehicle)
      .where(vehicles: { user_id: current_user.id })
      .order(created_at: :desc)
      .page(params[:page])

    render :index, status: :ok
  end

  def company_claims
    @user_order_reviews = UserOrderReview
      .includes(order: [:assigned_to])
      .joins(:order)
      .where(order: { company_id: params[:company_id] })
      .where(rating: ...3)
      .order(created_at: :desc)
      .page(params[:page])

    render :index, status: :ok
  end

  def by_order
    @user_order_review = UserOrderReview.find_by(order_id: params[:order_id])
    if @user_order_review.nil?
      render json: { user_order_review: nil }, status: :ok
    else
      validate_review_show
      render json: { user_order_review: @user_order_review.as_json }, status: :ok
    end
  end

  def company_ratings
    results = UserOrderReview
      .joins(order: :company)
      .where(companies: { id: params[:company_id] })
      .group(:rating)
      .count

    render json: results.as_json, status: :ok
  end

  private

  def user_order_review_params
    params.require(:user_order_review).permit(:id, :rating, :message, :order_id)
  end

  def set_user_order_review
    @user_order_review = UserOrderReview.includes(order: [vehicle: :user]).find(params[:id])
  end

  def validate_review_show
    return if @user_order_review.order.vehicle.user_id == current_user.id

    return if @user_order_review.order.created_by.company_id == params[:company_id].to_i

    render json: { errors: ['Unauthorized'] }, status: :unauthorized
  end
end
