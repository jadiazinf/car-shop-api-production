class Api::V1::ServicesController < ApplicationController
  before_action :set_service, only: %i[show update]

  def index
    @services = Service.all.page(params[:page].to_i)
  end

  def show; end

  def create; end

  def update; end

  private

  def service_params
    params.require(:service).permit(:name, :service_type, :description, :page)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
