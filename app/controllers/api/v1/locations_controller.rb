class Api::V1::LocationsController < ApplicationController
  before_action :set_location, only: %i[show update toggle_active]

  def index
    # where locaion is_active is true
    @locations = Location.where(is_active: true)
  end

  def show; end

  def create
    @location = Location.new(location_params)
    if @location.save
      render :show, status: :created
    else
      render :show, status: :unprocessable_content
    end
  end

  def update
    if @location.update(location_params)
      render :show, status: :ok
    else
      render :show, status: :unprocessable_content
    end
  end

  def toggle_active
    location_services = Locations::ToggleActive.new(@location, location_params[:active])
    location_services.perform
    render :show, status: :ok
  end

  def location_childrens
    @locations = Location.where(is_active: true, parent_location_id: params[:id])
    render :index, status: :ok
  end

  def location_by_type
    @locations = Location.where(is_active: true, location_type: params[:location_type])
    render :index, status: :ok
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:id, :name, :location_type, :parent_location_id, :active)
  end
end
