class Api::V1::VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i[update]

  def create
    service = Vehicle::Create.new(vehicle_params)
    valid, errors, vehicle = service.perform
    render_success_response(vehicle) if valid

    render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil, errors:)
  end

  def update
    if vehicle.update(vehicle_params)
      render_response(ok: true, status: :ok, data: vehicle, message: nil, errors: nil)
    else
      render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil,
                      errors: vehicle.errors)
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_response(ok: false, status: :unprocessable_entity, data: nil, message: nil, errors:)
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :year, :axles, :tires, :color, :vehicle_type,
                                    :load_capacity, :mileage, :engine_serial, :body_serial,
                                    :engine_type, :transmission, :is_active, :user_id, :model_id)
  end

  def render_response(obj)
    render 'application_response',
           status: :ok,
           locals: { ok: obj[:ok], status: obj[:status], data: obj[:data], message: obj[:message],
                     errors: obj[:errors] }
  end

  def render_unauthorized(errors)
    render_response(ok: false, status: :unauthorized, data: nil, message: nil, errors:)
  end

  def render_success_response(data)
    render_response(ok: true, status: :ok, data:, message: nil, errors: nil)
  end

  def render_internal_server_error(errors)
    render_response(ok: false, status: :internal_server_error, data: nil, message: nil, errors:)
  end
end
