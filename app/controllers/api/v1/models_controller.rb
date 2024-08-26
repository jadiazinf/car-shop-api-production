class Api::V1::ModelsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :authorize_superadmin, only: %i[create update]

  def index
    models = Model.where(is_active: true)
    render_response(ok: true, status: :ok, data: models, message: nil, errors: nil)
  end

  def show
    model = Model.find(params[:id])
    render_response(ok: true, status: :ok, data: model, message: nil, errors: nil)
  end

  def create
    service = Models::Create.new(model_params)
    valid, errors, model = service.handle
    unless valid
      render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil, errors:)
    end

    render_success_response(model) if valid
  end

  def update
    model = Model.find(params[:id])
    if model.update(model_params)
      render_response(ok: true, status: :ok, data: model, message: nil, errors: nil)
    else
      render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil,
                      errors: model.errors)
    end
  end

  def show_models_by_brand
    models = Model.where(brand_id: params[:id], is_active: true)
    render_response(ok: true, status: :ok, data: models, message: nil, errors: nil)
  end

  private

  def model_params
    params.require(:model).permit(:name, :brand_id)
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
