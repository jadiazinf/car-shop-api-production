class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_superadmin!, only: %i[create update]
  before_action :set_category, only: %i[show update]

  def index
    if params[:page].present?
      @categories = Category.where(is_active: true)
        .order(created_at: :desc).page(params[:page].to_i)
    else
      @categories = Category.where(is_active: true).order(created_at: :desc)
      render json: @categories.as_json(only: %i[id name is_active created_at updated_at]),
             status: :ok
      nil
    end
  end

  def show; end

  def create
    @category = Category.new(category_params.merge(is_active: true))

    if @category.save
      render :show, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @category.update(category_params)
      render :show, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :is_active)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
