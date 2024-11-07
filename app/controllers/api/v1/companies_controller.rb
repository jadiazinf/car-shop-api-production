class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_user!, unless: :devise_controller?,
                                     only: %i[show create update roles_by_company]
  before_action :authorize_admin!, only: %i[update]
  before_action :set_location, only: %i[create]
  before_action :set_company, only: %i[show update company_charter company_images roles_by_company]
  before_action :allow_iframe, only: %i[company_charter company_images]

  def index
    companies = Company.all
    render json: companies, status: :ok
  end

  def show
    render json: @company, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def create
    service = Companies::Create.new(company_params
                                                  .except(:location_id)
                                                  .merge(user: current_user, location: @location))
    response = service.perform
    if response[:ok]
      render json: { response: }, status: :created
    else
      render json: { response: }, status: :unprocessable_entity
    end
  end

  def update
    service = Companies::Update.new(company_params.merge(company: @company, user: current_user))
    response = service.perform
    if response[:ok]
      render json: { response: }, status: :ok
    else
      render json: { response: }, status: :unprocessable_entity
    end
  end

  def roles_by_company
    render json: current_user.roles(@company.id), status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def company_images
    company = Company.find(params[:id])
    image_urls = company.company_images.map { |image| url_for(image) }

    render json: { image_urls: }
  end

  def company_charter
    company = Company.find(params[:id])
    company_charter_url = url_for(company.company_charter)

    render json: { company_charter_url: }
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.permit(:id, :name, :dni, :email, :number_of_employees,
                  :address, :location_id, :company_charter, :disposition,
                  payment_methods: [], social_networks: [],
                  phone_numbers: [], company_images: [])
  end

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                                 :phone_number, :is_active, roles: [])
  end

  def set_user
    @user = User.find(user_params[:id])
  end

  def set_location
    @location = Location.find(company_params[:location_id])
  end

  def send_zip_file(data)
    send_data File.read(data[:zip]),
              filename: data[:filename],
              type: data[:type],
              disposition: data[:disposition]
  end

  def render_error(message)
    render json: { error: message }, status: :not_found
  end

  def allow_iframe
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end
end
