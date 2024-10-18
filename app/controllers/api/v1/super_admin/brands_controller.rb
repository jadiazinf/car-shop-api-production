class Api::V1::SuperAdmin::BrandsController < ApplicationController
  before_action :authenticate_user!, only: %i[update]
  before_action :authorize_superadmin!, only: %i[update create]

  def index
    brands = Brand.where(is_active: true)
    render_response(ok: true, status: :ok, data: brands, message: nil, errors: nil)
  end

  def show
    brand = Brand.find(params[:id])
    render_response(ok: true, status: :ok, data: brand, message: nil, errors: nil)
  end

  def create
    service = Brands::Create.new(brand_params[:name])
    valid, errors, brand = service.perform
    unless valid
      render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil, errors:)
    end

    render_success_response(brand) if valid
  end

  def update
    service = Brands::Update.new({ id: params[:id], new_brand_params: brand_params })
    valid, errors, brand = service.perform
    unless valid
      render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil, errors:)
    end

    render_success_response(brand) if valid
  end

  private

  def brand_params
    params.require(:brand).permit(:id, :name)
  end
end
