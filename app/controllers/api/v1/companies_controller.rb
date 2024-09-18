class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :authorize_admin!, only: %i[create update]
  before_action :set_user, :set_location, only: %i[create]

  def show_by_company_id
    company_id = params[:company_id]
    company = Company.find_by(company_id:)
    if company.nil?
      render json: { error: 'Company does not exist' }, status: :not_found
    else
      render json: company, status: :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def show_by_user_id
    user_id = params[:user_id]
    company = User.includes(:company).find(user_id).company
    if company.nil?
      render json: { error: 'User does not have a company registered' }, status: :not_found
    else
      render json: company, status: :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def create
    service = Companies::Create.new(company_params
                                                  .except(:location_id, :user_id)
                                                  .merge(users: [@user], location: @location))
    response = service.perform
    if response[:ok]
      render json: { response: }, status: :created
    else
      render json: { response: }, status: :unprocessable_entity
    end
  end

  def update
    service = Companies::Update.new(company_params.merge(id: params[:id]))
    response = service.perform
    if response[:ok]
      render json: { response: }, status: :ok
    else
      render json: { response: }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :dni, :email, :number_of_employees,
                                    :address, :location_id, :company_charter, :user_id,
                                    payment_methods: [], social_networks: [],
                                    phonenumbers: [], company_images: [])
  end

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                                 :phonenumber, :is_active, roles: [])
  end

  def set_user
    @user = User.find(company_params[:user_id])
  end

  def set_location
    @location = Location.find(company_params[:location_id])
  end
end
