class Api::V1::AdvancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advance, only: %i[show attach_image]
  before_action :set_service_order, only: %i[service_order_advances]
  before_action :set_company, only: %i[show service_order_advances]

  def show
    if @advance.belongs_to_user?(current_user) || @advance.belongs_to_company?(@company)
      render :show, status: :ok
    else
      render json: { errors: ['Advance not found'] }, status: :not_found
    end
  end

  def create
    @advance = Advance.new(advance_params)
    if @advance.save
      render :show, status: :created
    else
      render json: { errors: @advance.errors }, status: :unprocessable_entity
    end
  end

  def attach_image
    advance_params_for_image[:advance_images].each do |image|
      @advance.advance_images.attach(image)
    end
    @advance.save
    render :show, status: :ok
  end

  def service_order_advances
    if @service_order.belongs_to_user?(current_user) || @service_order.belongs_to_company?(@company)
      @advances = Advance.where(service_order_id: params[:service_order_id])
      render :index, status: :ok
    else
      render json: { errors: ['Order advances not found'] }, status: :not_found
    end
  end

  private

  def set_advance
    @advance = Advance.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def advance_params
    params.require(:advance).permit(:id, :description, :service_order_id, advance_images: [])
  end

  def advance_params_for_image
    params.permit(:id, advance_images: [])
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end
end
