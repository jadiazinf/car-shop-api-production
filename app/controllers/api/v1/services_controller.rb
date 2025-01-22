class Api::V1::ServicesController < ApplicationController
  before_action :set_service, only: %i[show update]
  before_action :authorize_admin!, only: %i[create update]

  def index
    @services = Service.where(is_active: true).includes(:category).page(params[:page].to_i)
  end

  def show; end

  def create
    @service = Service.new(service_params.merge(is_active: true))

    if @service.save
      render :show, status: :created
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @service.update(service_params)
      render :show, status: :ok
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:id, :name, :description, :company_id, :category_id,
                                    :price_for_motorbike, :price_for_car, :price_for_van,
                                    :price_for_truck, :is_active, :page)
  end

  def set_service
    @service = Service.includes(:category).where(id: params[:id], is_active: true).first
  end
end
