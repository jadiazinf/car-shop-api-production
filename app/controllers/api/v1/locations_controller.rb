class Api::V1::LocationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show update], raise: false
  skip_before_action :authorize_superadmin!, only: %i[index show], raise: false
  before_action :set_location, only: %i[show update toggle_active]

  def index
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
      render_success_response(@locations)
    else
      render_bad_request(@location.errors.full_messages)
    end
  end

  def toggle_active
    location_services = Locations::ToggleActive.new(@location, location_params[:active])
    location_services.perform
    render_success_response(@location)
  end

  def location_childrens
    @locations = Location.where(is_active: true, parent_location_id: params[:id])
    render_success_response(@locations)
  end

  def location_by_type
    @locations = Location.where(is_active: true, location_type: params[:location_type])
    render_success_response(@locations)
  end

  def location_parents
    @locations = Locations::LocationParents.new(params[:id]).perform
    result = []
    result = @locations.push(Location.find(params[:id])) unless @locations.nil?
    render_success_response(result)
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:id, :name, :location_type, :parent_location_id, :active,
                                     :company_id)
  end
end
