class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new_token]
  before_action :set_user, except: %i[new_token]

  def update
    UsersActivitiesLogs::Create.new(current_user, 'Update user info').perform
    if @user.update(user_params)
      render :show, status: :ok
    else
      render :show, status: :unprocessable_content
    end
  end

  def user_companies
    companies = UserCompany.where(user_id: @user.id, is_active: true).includes(:company)
    render json: companies.as_json(include: :company), status: :ok
  end

  def search_by_filters
    name = params[:name].to_s.strip
    email = params[:email].to_s.strip
    dni = params[:dni].to_s.strip
    @users = Users::FilterService.new(name:, email:, dni:).perform
    render json: @users, status: :ok
  end

  def new_token
    new_token_service = Users::GenerateToken.new(params[:id])
    token = new_token_service.perform
    response.set_header('Authorization', "Bearer #{token}")
    if token.nil?
      render json: { error: 'Invalid user' }, status: :bad_request
    else
      render json: { message: 'Token refreshed successfully' }, status: :ok
    end
  end

  def vehicles
    user = User.find(params[:id])
    @vehicles = user.vehicles.where(is_active: true).includes(model: %i[brand]).page(params[:page])
  end

  def all_vehicles
    @vehicles = current_user.vehicles.where(is_active: true).includes(model: %i[brand])
    render json: @vehicles.as_json(include: { model: { include: :brand } }), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                                 :gender, :phone_number, :location_id, :is_active, roles: [])
  end

  def set_user
    @user = current_user
  end
end
