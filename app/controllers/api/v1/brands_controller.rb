class Api::V1::BrandsController < ApplicationController
  before_action :authenticate_user!, only: %i[update]
  before_action :authorize_superadmin, only: %i[update]
  def index
    brands = Brand.where(is_active: true)
    render_response(ok: true, status: :ok, data: brands, message: nil, errors: nil)
  end

  def show
    brand = Brand.find(brand_params[:id])
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

  def render_response(obj)
    render 'application_response',
           status: :ok,
           locals: { ok: obj[:ok], status: obj[:status], data: obj[:data], message: obj[:message],
                     errors: obj[:errors] }
  end

  def render_unauthorized(errors)
    render_response(ok: false, status: :unauthorized, data: nil, message: 'Unauthorized', errors:)
  end

  def render_success_response(data)
    render_response(ok: true, status: :ok, data:, message: nil, errors: nil)
  end

  def render_internal_server_error(errors)
    render_response(ok: false, status: :internal_server_error, data: nil, message: nil, errors:)
  end

  def authorize_superadmin
    return if current_user[:roles].include?('superadmin')

    render_unauthorized(nil)
  end
end
